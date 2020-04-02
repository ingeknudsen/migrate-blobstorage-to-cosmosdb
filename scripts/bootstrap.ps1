$url = "https://aka.ms/csdmtool"
$output = "$PSScriptRoot\dt.zip"
$start_time = Get-Date

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)

$unzipTo = "$PSScriptRoot\unzipped\"
Expand-Archive -LiteralPath $output -DestinationPath $unzipTo

$Command = "$unzipTo\drop\dt.exe"

$tables = @("Roles", "Experiences", "QAComments", "Resources", "RolesSnapshot")
foreach ($table in $tables) {
    $consoleLog = "Migrating " + $table
    Write-Output $consoleLog
    $Parms = "/s:AzureTable /s.ConnectionString:" + $env:BLOB_STORAGE_CONNECTION + " /s.Table:" + $table + "  /t:TableAPIBulk /t.ConnectionString:" + $env:COSMOSDB_CONNECTION + " /t.TableName:" + $table

    $Prms = $Parms.Split(" ")
    & "$Command" $Prms
}

Write-Output "All tables migrated"