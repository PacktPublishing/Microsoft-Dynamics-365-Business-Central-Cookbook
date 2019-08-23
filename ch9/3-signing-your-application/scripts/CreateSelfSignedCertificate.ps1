$certificateFile = 'c:\certificate.pfx'
$certificatePassword = 'Pass@word1'
$certificate = New-SelfSignedCertificate –Type CodeSigningCert –Subject “CN=SelfSignedCertDemo”
Export-PfxCertificate -Cert $(‘cert:\localMachine\my\’ + $certificate.thumbprint) `
    -FilePath $certificateFile `
    -Password $(ConvertTo-SecureString -String $certificatePassword -Force -AsPlainText) | Out-Null
Write-Host "Certificate created: $certificateFile"