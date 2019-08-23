$containerName = 'nav2018'
$conversionFolder = 'c:\programdata\navcontainerhelper\extensions\' + $containerName + '\my\convert'
$modifiedFolder   = Join-Path $conversionFolder "\modified"

Export-NavContainerObjects -containerName $containerName -objectsFolder $modifiedFolder -exportTo "txt folder (new syntax)" -filter "Modified = Yes"