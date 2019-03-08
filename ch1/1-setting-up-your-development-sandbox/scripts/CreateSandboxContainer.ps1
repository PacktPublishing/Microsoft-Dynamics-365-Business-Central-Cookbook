install-module navcontainerhelper -force

# set to $true to accept the eula (https://go.microsoft.com/fwlink/?linkid=861843)
$accept_eula = $false

# set the name of your container (must be 15 characters or less)
$containername = ''

# set image to use to create container (see here for available images: https://hub.docker.com/_/microsoft-businesscentral-sandbox﻿)
$navdockerimage = 'microsoft/bcsandbox:ca'

# the user you use to login to the Business Central client (is a SUPER user)
$userName = "admin"
$password = "Pass@word1"

# set the secure Url to your Business Central license file (leave blank to use the demo license)
$licenseFileUri = ''

$credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $userName, $password

New-NavContainer -accept_eula:$accept_eula `
                 -containername $containername `
                 -auth UserPassword `
                 -Credential $credential `
                 -licenseFile $licenseFileUri `
                 -includeCSide `
                 -alwaysPull `
                 -doNotExportObjectsToText `
                 -usessl:$false `
                 -updateHosts `
                 -assignPremiumPlan `
                 -shortcuts Desktop `
                 -imageName $navdockerimage `
                 -useBestContainerOS