$containerName = '<yourContainer>'
$applicationFileFolder = '<yourAppFileFolder>'
$certificatePassword = '<yourCertifictePassword>'
$certificateFile = '<yourCertificateFile>'
Get-ChildItem -Path $applicationFileFolder -Filter '*.app' | ForEach-Object {
    $containerAppFile = "C:\ProgramData\NavContainerHelper\Extensions\$containerName\my\$($_.Name)"
    
    Copy-Item -Path $_.FullName -Destination $containerAppFile -Force
      
    Sign-NavContainerApp -appFile $containerAppFile `
         -containerName $containerName `
         -pfxFile $certificateFile `
         -pfxPassword $(ConvertTo-SecureString -String $certificatePassword -AsPlainText -Force)
}