$containerName = 'nav2018'
$conversionFolder = 'c:\programdata\navcontainerhelper\extensions\' + $containerName + '\my\convert'
$modifiedFolder   = Join-Path $conversionFolder "\modified"
$myOriginalFolder   = Join-Path $conversionFolder "\myOriginal"
$deltaFolder   = Join-Path $conversionFolder "\delta"

Create-MyDeltaFolder -containerName $containerName -modifiedFolder $modifiedFolder -myDeltaFolder $deltaFolder -myOriginalFolder $myOriginalFolder -useNewSyntax