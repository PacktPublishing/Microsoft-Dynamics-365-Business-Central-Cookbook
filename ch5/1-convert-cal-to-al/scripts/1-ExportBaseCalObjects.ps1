$containerName = 'nav2018'
$conversionFolder = 'c:\programdata\navcontainerhelper\extensions\' + $containerName + '\my\convert'
$originalFolder   = Join-Path $conversionFolder "\original"

Export-NavContainerObjects -containerName $containerName -objectsFolder $originalFolder -filter "" -ExportTo "txt folder (new syntax)"