function Get-MrAccessToken {
    [CmdletBinding()]
    param (
        [string]$AccessTokenPath = "$env:USERPROFILE\.creds\Modrinth\ModrinthAccessToken.xml"
    )

    process {
        if (!(Test-Path $AccessTokenPath)) {
            New-MrAccessToken
        }
    
        Import-Clixml $AccessTokenPath | ConvertFrom-SecureString -AsPlainText
    }
}