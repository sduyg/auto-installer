Write-Host "starting download, unzip and silent install of dropbox"

&md -Path 'C:\MyInstaller\Dropbox'

$dropboxPath = "C:\MyInstaller\Dropbox"
$dropboxSetupsPath = "C:\MyInstaller\Dropbox\Dropbox%202.6.2.exe"
$urlDropbox = "https://d1ilhw0800yew8.cloudfront.net/client/Dropbox%202.6.2.exe"

Write-Host "downloading dropbox"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlDropbox,$dropboxSetupsPath)

Write-Host "silent installing dropbox"

& $dropboxPath\Dropbox%202.6.2.exe /S

$dropboxExeFile = "C:\Users\caner.cavus\AppData\Roaming\Dropbox\bin\Dropbox.exe"

While (1 -eq 1) {
    IF (Test-Path $dropboxExeFile) {
        break
    }
}


Write-Host "pining dropbox to start menu"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Users\caner.cavus\AppData\Roaming\Dropbox\bin')    
$item = $folder.Parsename('Dropbox.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Start Men&u'}
if ($verb) {$verb.DoIt()}


Write-Host "dropbox installation and pining to start menu completed"
