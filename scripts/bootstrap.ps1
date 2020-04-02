$url = "https://aka.ms/csdmtool"
$output = "$PSScriptRoot\dt.zip"
$start_time = Get-Date

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)

$unzipTo = "$PSScriptRoot\unzipped\"
Expand-Archive -LiteralPath $output -DestinationPath $unzipTo

Write-Output "Execute"
$Command = "$unzipTo\drop\dt.exe"

& "$Command"
# [System.Diagnostics.Process]::Start($Command)

Write-Output "IKNU TEST: Done executing"