# Ensure the script is running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator."
    break
}

# Set execution policy to allow script execution
Set-ExecutionPolicy Bypass -Scope Process -Force

# Install Chocolatey
Write-Output "Installing Chocolatey..."
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Refresh environment variables to recognize choco command
$env:Path += ";$env:ALLUSERSPROFILE\chocolatey\bin"

# List of packages to install
$packages = @(
    "brave",
    "calibre",
    "chromium",
    "discord",
    "ferdium",
    "firefox",
    "flow-launcher",
    "foxitreader",
    "git",
    "github-desktop",
    "handbrake",
    "marktext",
    "microsoft-teams",
    "obsidian",
    "pdf24",
    "powertoys",
    "qgis-ltr",
    "revo-uninstaller",
    "starship",
    "steam",
    "vivaldi",
    "vlc",
    "vscode",
    "vscodium",
    "waterfox",
    "zotero"
)

# Install each package
foreach ($package in $packages) {
    Write-Output "Installing $package..."
    choco install $package -y
}
