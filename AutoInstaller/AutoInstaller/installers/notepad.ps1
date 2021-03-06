&md -Path 'C:\MyInstaller'

Write-Host "starting download, unzip and silent install of notepad"

&md -Path 'C:\MyInstaller\NotePad'

$notePadPath = "C:\MyInstaller\Notepad"
$notePadSetupPath = "C:\MyInstaller\Notepad\npp.6.5.3.Installer.exe"
$notePadUrl = "http://download.tuxfamily.org/notepadplus/6.5.3/npp.6.5.3.Installer.exe"

Write-Host "downloading notepad"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($notePadUrl,$notePadSetupPath)

Write-Host "silent installing notepad"

& $notePadPath\npp.6.5.3.Installer.exe /S

$notePadExeFile = "C:\Program Files (x86)\Notepad++\notepad++.exe"

While (1 -eq 1) {
    IF (Test-Path $notePadExeFile) {
        break
    }
}

Write-Host "pining notePad++ to taskBar"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\Notepad++')    
$item = $folder.Parsename('notepad++.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb) {$verb.DoIt()}

Write-Host "notepad++ silent installation and pining to taskBar completed"