Write-Host "starting download, unzip and silent install of skype"

&md -Path 'C:\MyInstaller\Skype'

$skypePath = "C:\MyInstaller\Skype"
$skypeSetupsPath = "C:\MyInstaller\Skype\SkypeSetup.exe"
$urlSkype = "http://download.skype.com/b60a581173253f539ed6dde04ff65db3/SkypeSetup.exe"

Write-Host "downloading skype"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlSkype,$skypeSetupsPath)

Write-Host "silent installing skype"

& $skypePath \SkypeSetup.exe /qn


$skypeExeFile = "C:\Program Files (x86)\Skype\Phone\Skype.exe";


Write-Host "pining skype to start menu"

While (1 -eq 1) {
    IF (Test-Path $skypeExeFile) {
        break
    }
}


$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\Skype\Phone')    
$item = $folder.Parsename('Skype.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Start Men&u'}
if ($verb) {$verb.DoIt()}

Write-Host "Skype installation and pining to start menu completed"