write-Host "starting download, silent install of firefox"

&md -Path 'C:\MyInstaller\Firefox'

$firefoxPath = "C:\MyInstaller\Firefox"
$firefoxSetupsPath = "C:\MyInstaller\Firefox\Firefox-26.0-en-US.msi"
$urlFirefox = "http://hicap.frontmotion.com.s3.amazonaws.com/Firefox/Firefox-26.0/Firefox-26.0-en-US.msi"

Write-Host "downloading firefox"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlFirefox,$firefoxSetupsPath)

Write-Host "silent installing firefox"

&msiexec /i $firefoxSetupsPath /qn

$firefoxExeFile = "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"

While (1 -eq 1) {
    IF (Test-Path $firefoxExeFile) {
        break
    }
}

Write-Host "pining firefox to TaskBar"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\Mozilla Firefox')    
$item = $folder.Parsename('firefox.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb) {$verb.DoIt()}

Write-Host "pining snippingTool to taskBar completed"

Write-Host "firefox silent installation and pining to taskBar completed"


Write-Host "pining snippingTool to TaskBar"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Windows\System32')    
$item = $folder.Parsename('SnippingTool.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb) {$verb.DoIt()}

Write-Host "pining snippingTool to taskBar completed"