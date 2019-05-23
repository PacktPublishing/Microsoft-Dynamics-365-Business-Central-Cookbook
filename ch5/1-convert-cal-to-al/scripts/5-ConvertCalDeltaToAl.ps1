$containerName = 'nav2018'
$conversionFolder = 'c:\programdata\navcontainerhelper\extensions\' + $containerName + '\my\convert'
$deltaFolder   = Join-Path $conversionFolder "\delta"
$resultFolder   = Join-Path $conversionFolder "\result"

Convert-Txt2Al -containerName $containerName -myAlFolder $resultFolder -myDeltaFolder $deltaFolder -startId 50000