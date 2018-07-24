function Install-MyConfig {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    $apps = "git", "poshgit", "vscode", "vscode-powershell", "googlechrome"
    choco install $apps -y
}