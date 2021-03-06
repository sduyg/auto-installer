Write-Host "starting download, unzip and silent install of 7 zip"

&md -Path 'C:\MyInstaller\7 Zip'

$7zipPath = "C:\MyInstaller\7 Zip"
$7zipsetupsPath = "C:\MyInstaller\7 Zip\7z920.exe" 
$url7zip = "http://freefr.dl.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920.exe"

Write-Host "downloading 7 zip"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($url7zip,$7zipsetupsPath)

Write-Host "silent installing notepad"

& $7zipsetupsPath \7z920.exe /S


$7zipFileExeFile = "C:\Program Files (x86)\7-Zip\7zFM.exe"

Write-Host "pining 7zip to start menu"

While (1 -eq 1) {
    IF (Test-Path $7zipFileExeFile) {
        break
    }
}



$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\7-Zip')    
$item = $folder.Parsename('7zFM.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Start Men&u'}
if ($verb) {$verb.DoIt()}

Write-Host "7 zip installation and pining to start menu completed"