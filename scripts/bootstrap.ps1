$url = "https://aka.ms/csdmtool"
$output = "$PSScriptRoot\dt.zip"
$start_time = Get-Date

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)

$unzipTo = "$PSScriptRoot\unzipped\"
Expand-Archive -LiteralPath $output -DestinationPath $unzipTo

Write-Output "Execute"
$Command = "$unzipTo\drop\dt.exe"
$Parms = "/s:AzureTable /s.ConnectionString:" + $env:BLOB_STORAGE_CONNECTION + " /s.Table:Roles  /t:TableAPIBulk /t.ConnectionString:" + $env:COSMOSDB_CONNECTION + " /t.TableName:Roles"

$Prms = $Parms.Split(" ")
& "$Command" $Prms

Write-Output "IKNU TEST: Done executing"