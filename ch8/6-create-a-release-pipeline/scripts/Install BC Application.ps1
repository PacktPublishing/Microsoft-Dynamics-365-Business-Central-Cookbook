Get-ChildItem -Path (Join-Path -Path $env:System_ArtifactsDirectory -ChildPath ($env:Release_PrimaryArtifactSourceAlias + '\televisionShowApp')) -Filter '*.app' | ForEach-Object {
  Publish-NavContainerApp -containerName $env:containerName -appFile $_.FullName -skipVerification -sync -install
}