Install-Module -Name BcContainerHelper -Force

# set to $true to accept the eula (https://go.microsoft.com/fwlink/?linkid=861843)
$accept_eula = $false

# set the name of your container (must be 15 characters or less)
$containername = ''

# set the localization to use (NA = North America, W1 = Worldwide, etc.)
$country = 'NA'

# set the container isolation mode
$isolation = 'process' # (can use 'hyperv' if 'process' isolation fails)

# the user you use to login to the Business Central client (is a SUPER user)
$userName = "admin"
$password = ConvertTo-SecureString -String "Pass@word1" -AsPlainText -Force

# set the secure Url to your Business Central license file (leave blank to use the demo license)
$licenseFileUri = ''

# set the DNS address to use from within the container
$dnsAddress = '8.8.8.8'

$credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $userName, $password

$artifactUrl = Get-BCArtifactUrl -type OnPrem -country $country -version '13'

New-BCContainer -accept_eula:$accept_eula `
                -accept_outdated `
                -containername $containername `
                -artifactUrl $artifactUrl `
                -auth UserPassword `
                -Credential $credential `
                -licenseFile $licenseFileUri `
                -updateHosts `
                -dns $dnsAddress `
                -assignPremiumPlan `
                -shortcuts Desktop `
                -doNotExportObjectsToText `
                -includeCSide `
                -isolation $isolation