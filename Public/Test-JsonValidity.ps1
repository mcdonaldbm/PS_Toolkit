<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example 1
.EXAMPLE
    Example 2
#>
function Test-JsonValidity {
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        $Path
    )
    try {
        $json = ConvertFrom-Json (Get-Content $Path) -ErrorAction stop
        $validJson = $True
    } catch {
        $validJson = $false
    }

    return $validJson
}