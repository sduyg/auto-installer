Write-Host "starting download, silent install of Chrome"

&md -Path 'C:\MyInstaller\Chrome'

$chromeUrl = "http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
$chromePath = "C:\MyInstaller\Chrome"
$chromeSetupPath = "C:\MyInstaller\Chrome\chrome_installer.exe"

Write-Host "downloading chrome"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($chromeUrl, $chromeSetupPath)

Write-Host "silent installing chrome"

& $chromePath\chrome_installer.exe

$chromeExeFile = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

While (1 -eq 1) {
    IF (Test-Path $chromeExeFile) {
        break
    }
}

Write-Host "pining chrome to TaskBar"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\Google\Chrome\Application')    
$item = $folder.Parsename('chrome.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb) {$verb.DoIt()}


Write-Host "installation and pining chrome to taskBar completed"