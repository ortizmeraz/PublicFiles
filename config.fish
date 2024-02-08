if status is-interactive
    # Commands to run in interactive sessions can go here
end
neofetch
starship init fish | source


abbr ls 'exa -l -g -F --icons'



abbr ~~ 'cd ~'
abbr GH 'cd /mnt/e/GitHub'
abbr CAMMM 'cd /mnt/e/GitHub/CAMMM-2.0'

alias mini='ssh omar@192.168.0.15'
alias true='ssh root@truenas.lan'
alias next='ssh omar@nextcloud.lan'
alias searx='ssh searx.lan'
alias weather='curl wttr.in/Montreal'
alias pihole='ssh pi@192.168.0.2'
alias hassio='ssh hassio@192.168.0.10'
alias pibox='ssh omar@192.168.0.21'
alias piserver='ssh omar@192.168.0.25'
alias londock='ssh omar@192.168.0.27'
alias searxy='ssh omar@192.168.0.28'
alias site='ssh omar@192.168.0.31'
