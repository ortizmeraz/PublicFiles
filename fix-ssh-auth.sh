#!/usr/bin/env bash
# Enable SSH password and public-key authentication on Ubuntu Server.
set -Eeuo pipefail

if (( EUID != 0 )); then
    exec sudo bash "$0" "$@"
fi

config_dir=/etc/ssh/sshd_config.d
config_file="$config_dir/00-00-local-password-auth.conf"
sshd=/usr/sbin/sshd

if [[ ! -x "$sshd" ]] || ! systemctl is-active --quiet ssh; then
    echo 'Error: OpenSSH server must be installed and ssh.service must be running.' >&2
    exit 1
fi

# Ensure the original configuration is valid before changing anything.
"$sshd" -t
mkdir -p "$config_dir"
backup=''
if [[ -L "$config_file" || ( -e "$config_file" && ! -f "$config_file" ) ]]; then
    echo "Error: $config_file is not a regular file." >&2
    exit 1
fi
if [[ -f "$config_file" ]]; then
    backup=$(mktemp /var/backups/ssh-password-auth.XXXXXXXX)
    cp -p -- "$config_file" "$backup"
fi

stage=$(mktemp "$config_dir/.password-auth.XXXXXXXX")
changed=0
reloaded=0
cleanup() {
    local rc=$?
    trap - EXIT
    if (( rc != 0 && changed == 1 )); then
        echo 'Failed; restoring previous SSH configuration.' >&2
        if [[ -n "$backup" ]]; then
            cp -p -- "$backup" "$config_file" || echo "Restore failed. Backup: $backup" >&2
        else
            rm -f -- "$config_file" || echo "Could not remove $config_file" >&2
        fi
        if (( reloaded == 1 )); then
            "$sshd" -t && systemctl reload ssh || echo 'Could not reload restored configuration; check the console.' >&2
        fi
    fi
    rm -f -- "$stage"
    exit "$rc"
}
trap cleanup EXIT

cat > "$stage" <<'CONFIG'
# Local SSH authentication override.
PasswordAuthentication yes
PubkeyAuthentication yes
CONFIG
chmod 644 "$stage"
changed=1
mv -f -- "$stage" "$config_file"

"$sshd" -t
effective=$("$sshd" -T)
if ! grep -qx 'passwordauthentication yes' <<< "$effective" ||
   ! grep -qx 'pubkeyauthentication yes' <<< "$effective" ||
   ! grep -qx 'authenticationmethods any' <<< "$effective"; then
    echo 'Error: another SSH directive still overrides or restricts authentication.' >&2
    grep -E '^(passwordauthentication|pubkeyauthentication|authenticationmethods) ' <<< "$effective" >&2
    exit 1
fi

reloaded=1
systemctl reload ssh
systemctl is-active --quiet ssh
printf '\nSSH configuration updated successfully.\n'
grep -E '^(usepam|passwordauthentication|pubkeyauthentication|authenticationmethods) ' <<< "$effective"
printf '\nConfiguration: %s\n' "$config_file"
if [[ -n "$backup" ]]; then
    printf 'Previous local configuration backed up to: %s\n' "$backup"
fi
printf '\nKeep your console open and test a new SSH connection.\n'
printf 'User-specific Match rules or account restrictions may still apply.\n'
