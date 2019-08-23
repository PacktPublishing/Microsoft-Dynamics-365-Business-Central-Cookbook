$username = '<replace with your userName>'
$webServicesKey = '<replace with your web services key'
$azureDomain = 'replace with your Azure domain'
$companyId = '<replace with the company id from Step 1>'

$credentials = "$($username):$($webServicesKey)"
$encodedCredentials = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($credentials))
$headers = @{ Authorization = "Basic $encodedCredentials" }

$url = 'https://api.businesscentral.dynamics.com/v1.0/' + $azureDomain + '/sandbox/api/v1.0/companies(' + $companyId + ')/items'

$params = @{"displayName"="My Api item";
   "itemCategoryCode"="MISC";
   "type"="Inventory";
}

Invoke-RestMethod -Uri $url -Method POST -Headers $headers -Body ($params|ConvertTo-Json) -ContentType "application/json"