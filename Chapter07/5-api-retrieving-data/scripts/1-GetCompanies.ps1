$username = '<replace with your userName>'
$webServicesKey = '<replace with your web services key'
$azureDomain = 'replace with your Azure domain'

$credentials = "$($username):$($webServicesKey)"
$encodedCredentials = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($credentials))
$headers = @{ Authorization = "Basic $encodedCredentials" }

$url = 'https://api.businesscentral.dynamics.com/v1.0/' + $azureDomain + '/sandbox/api/v1.0/companies'
Invoke-RestMethod -Uri $url -Method GET -Headers $headers | ConvertTo-Json