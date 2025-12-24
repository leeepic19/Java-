$mavenUrl = 'https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip'
$downloadPath = "$env:TEMP\apache-maven-3.9.6.zip"
$installPath = 'C:\apache-maven-3.9.6'
Write-Host 'Downloading Maven...'
Invoke-WebRequest -Uri $mavenUrl -OutFile $downloadPath -UseBasicParsing
Write-Host 'Extracting...'
Expand-Archive -Path $downloadPath -DestinationPath 'C:\' -Force
Write-Host 'Done! Maven installed to C:\apache-maven-3.9.6'
