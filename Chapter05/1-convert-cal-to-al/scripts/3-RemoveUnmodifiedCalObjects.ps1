$containerName = 'nav2018'
$conversionFolder = 'c:\programdata\navcontainerhelper\extensions\' + $containerName + '\my\convert'
$originalFolder   = Join-Path $conversionFolder "\original"
$modifiedFolder   = Join-Path $conversionFolder "\modified"
$myOriginalFolder   = Join-Path $conversionFolder "\myOriginal"

Create-MyOriginalFolder -originalFolder $originalFolder -modifiedFolder $modifiedFolder -myoriginalFolder $myOriginalFolder