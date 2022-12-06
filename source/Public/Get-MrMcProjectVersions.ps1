function Get-MrMcProjectVersions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline,Position=0,ParameterSetName="Get project version info by id")][String]$Id,
        [Parameter(Mandatory,ParameterSetName="List project versions")][string]$Identifier,
        [Parameter(ParameterSetName="List project versions")][array]$loaders,
        [Parameter(ParameterSetName="List project versions")][array]$game_versions,
        [Parameter(ParameterSetName="List project versions")][ValidateSet("true","false")][string]$featured
    )

    process {
        $baseUri = "https://api.modrinth.com/v2"

        switch ($PsCmdlet.ParameterSetName) {
            "List project versions" {
                $uri = "$baseUri/project/$Identifier/version"
                $PSBoundParameters.Keys.ForEach({
                    if ($_ -notlike "Identifier") {
                        $key = $_
                        $value = $PSBoundParameters.$key

                        if (([array]$PSBoundParameters.Keys)[1] -eq $key) {
                            $delimiter = "?"
                        } else {
                            $delimiter = "&"
                        }

                        if ($value.gettype().BaseType.Name -eq "Array") {
                            $appendString = "[`"$($value.ToLower() -join '","')`"]"
                        }
                        elseif ($value.gettype().name -eq "String") {
                            $appendString = $value.ToLower()
                        }

                        $uri = "$uri$delimiter$key=$appendString"
                    }
                })
            }
            "Get project version info by id" {
                $uri = "$baseUri/version/$id"
            }
        }

        $splat = @{
            "Uri" = $uri
            "Method" = "GET"
            "Headers" = @{
                "Authorization" = Get-MrAccessToken
            }
        }
        Invoke-RestMethod @splat
    }
}