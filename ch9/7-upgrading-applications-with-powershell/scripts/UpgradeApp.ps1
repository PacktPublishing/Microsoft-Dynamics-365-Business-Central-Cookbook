$appFile = '<pathToAppFile>'
$appName = 'ALProject1'
$appVersion = '1.1.0.0'
$serverInstanceName = '<yourServerInstanceName>'
$rtcPath = "C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\*\RoleTailored Client"

Import-Module $(Join-Path $rtcPath 'Microsoft.Dynamics.Nav.Apps.Management.psd1') -DisableNameChecking -Force

Publish-NAVApp -ServerInstance $serverInstanceName -Path $appFile -PackageType Extension -SkipVerification
Sync-NavApp -ServerInstance $serverInstanceName -Name $appName -Version $appVersion -Tenant Default
Start-NAVAppDataUpgrade -ServerInstance $serverInstanceName -Name $appName -Version $appVersion