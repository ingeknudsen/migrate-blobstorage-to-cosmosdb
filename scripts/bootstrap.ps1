$url = "https://aka.ms/csdmtool"
$output = "$PSScriptRoot\dt.zip"
$start_time = Get-Date

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)

$unzipTo = "$PSScriptRoot\unzipped\"
Expand-Archive -LiteralPath $output -DestinationPath $unzipTo

Get-ChildItem -Path $unzipTo\drop

Write-Output "IKNU TEST: Done unzipping"