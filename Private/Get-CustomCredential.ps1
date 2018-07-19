function Get-Credential {
    Param(
        [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
        $name
    )
    if (Test-Path HKCU:\Software\Credentials) {
        $props = Get-ItemProperty HKCU:\Software\Credentials\$name
        $password = ConvertTo-SecureString $props.Password
        $username = $props.Username
        $credentialobject = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username,$password
    } else {
        Write-Error -Message "Credential Object does not exist, try running setup again (New-CustomCredential)" -ErrorAction Stop
    }
    return $credentialobject.GetNetworkCredential()
}