function New-Credential {
    Param(
        [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
        $name="MyCred",
        [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$false,
            Position=1)]
        $creds=($(Get-Credential))
    )
    if (!(Test-Path HKCU:\Software\Credentials)) {
        try {
            New-Item -Path HKCU:\Software -Name Credentials -Force
        } catch {
            throw
        }
    }

    $username = $creds.UserName
    $spassword = ConvertFrom-SecureString -SecureString $creds.Password

    New-Item -Path HKCU:\Software\Credentials -Name $name -Force
    New-ItemProperty -Path HKCU:\Software\Credentials\$name -PropertyType String -Name Username -Value $username
    New-ItemProperty -Path HKCU:\Software\Credentials\$name -PropertyType String -Name Password -Value $spassword
}