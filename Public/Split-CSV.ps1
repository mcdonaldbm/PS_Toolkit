<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Split-CSV
{
    [CmdletBinding()]
    Param
    (
        # Path to CSV
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Path,

        # Number of CSV's to export, exports an even number of rows in each CSV
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $NumExported
    )
    
    $csvPath = Get-ChildItem $Path

    # Get number of lines in CSV
    # Using this instead of Import-CSV | Measure-Object.  Much faster to read from stream than object
    [int]$LinesInFile = 0
    $reader = New-Object IO.StreamReader "$csvPath"
    while ($reader.ReadLine() -ne $null)
        {
        $LinesInFile++
    }
    $reader.Dispose()

    # Get number of lines per exported CSV
    $rowsper = [Math]::Round($LinesInFile/$NumExported)

    # Get path's parent to use for CSV export
    $parent = (Get-Item $csvPath).DirectoryName
    $basename = (Get-Item $csvPath).BaseName

    # Set initial values before the for loop that creates the export CSV's
    $counter = 0
    $startrow = 0

    $csv = Import-CSV $csvPath

    for ($i=0; $i -lt $NumExported; $i++) {
        $csv | Select-Object -Skip $startrow -First $rowsper | Export-CSV "$parent\$basename$counter.csv" -NoTypeInformation
        $startrow = $startrow + $rowsper
        $counter++
    }
}