function New-MrAccessToken {
    [CmdletBinding()]
    param (
        [string]$AccessTokenPath = "$env:USERPROFILE\.creds\Modrinth\ModrinthAccessToken.xml"
    )

    process {
        $ApiKey = Read-Host "Enter Modrinth API key" -AsSecureString
    
        #Create parent folders of the access token file
        $AccessTokenDir = $AccessTokenPath.Substring(0, $AccessTokenPath.lastIndexOf('\'))
        if (!(Test-Path $AccessTokenDir)) {
            $null = New-Item -ItemType Directory $AccessTokenDir
        }
    
        #Create access token file
        $ApiKey | Export-Clixml $AccessTokenPath
    }
}