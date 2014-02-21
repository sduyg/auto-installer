Write-Host "starting download and silent install of mRemoteNG"


&md -Path 'C:\MyInstaller\MRemoteNG'

$urlmRemoteNG = "http://downloads.mremoteng.org/mRemoteNG-Installer-1.72.exe"
$mRemoteNGPath = "C:\MyInstaller\MRemoteNG"
$mRemoteNGSetupPath = "C:\MyInstaller\MRemoteNG\mRemoteNG-Installer-1.72.exe" 

Write-Host "downloading mRemoteNG"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlmRemoteNG, $mRemoteNGSetupPath)


Write-Host "silent installing mRemoteNG"

& $mRemoteNGPath\mRemoteNG-Installer-1.72.exe /S 

$mRemoteNGExeFile  = "C:\Program Files (x86)\mRemoteNG\mRemoteNG.exe"

While (1 -eq 1) {
    IF (Test-Path $mRemoteNGExeFile) {
        break
    }
}

Write-Host "pining mRemoteNG to TaskBar"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\mRemoteNG')    
$item = $folder.Parsename('mRemoteNG.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb) {$verb.DoIt()}


Write-Host "mRemoteNG silent installation and pining to startmenu completed"