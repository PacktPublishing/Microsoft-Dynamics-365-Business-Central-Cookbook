if (Test-NavContainer -containerName $(containerName))
{
  Remove-NavContainer -containerName $(containerName)
}

New-NavContainer -containerName $(containerName) `
  -accept_eula `
  -accept_outdated `
  -auth NavUserPassword `
  -Credential (New-Object pscredential $(containerUserName), (ConvertTo-SecureString -String $(containerPassword) -AsPlainText -Force)) `
  -doNotExportObjectsToText `
  -imageName $(imageName) `
  -alwaysPull `
  -shortcuts CommonStartMenu `
  -restart always `
  -updateHosts `
  -useBestContainerOS `
  -assignPremiumPlan `
  -additionalParameters @("--volume ""$($env:Agent_HomeDirectory):C:\Agent""")