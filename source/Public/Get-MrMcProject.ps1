function Get-MrMcProject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][String]$Identifier
    )

    process {
        $splat = @{
            "Uri" = "https://api.modrinth.com/v2/project/$Identifier"
            "Method" = "GET"
            "Headers" = @{
                "Authorization" = Get-MrAccessToken
            }
        }
        Invoke-RestMethod @splat
    }
}