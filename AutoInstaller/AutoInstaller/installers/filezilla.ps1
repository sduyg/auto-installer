Write-Host "starting download and silent install of FileZilla"


&md -Path 'C:\MyInstaller\FileZilla'

$fileZillaPath = "C:\MyInstaller\FileZilla"
$fileZillaSetupPath = "C:\MyInstaller\FileZilla\FileZilla_3.7.4_win32-setup.exe"
$urlFileZilla = "http://sourceforge.net/projects/filezilla/files/FileZilla_Client/3.7.4/FileZilla_3.7.4_win32-setup.exe/download?accel_key=57%3A1392039423%3Ahttps%253A//filezilla-project.org/download.php%3Add4ca924%24fcc9245ba56fd376882b9b28129c135571d01aa2&click_id=6cd8cce6-9258-11e3-941c-0200ac1d1d9f&source=accel" 

Write-Host "downloading FileZilla"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlFileZilla, $fileZillaSetupPath)

Write-Host "silent installing FileZilla"


& $fileZillaPath\FileZilla_3.7.4_win32-setup.exe /S 


Write-Host "pining fileZilla to TaskBar"

$fileZillaExeFile = "C:\Program Files (x86)\FileZilla FTP Client\filezilla.exe"

Write-Host "pining fileZilla to start menu "

While (1 -eq 1) {
    IF (Test-Path $fileZillaExeFile) {
        #file exists. break loop
        break
    }
}

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\FileZilla FTP Client')    
$item = $folder.Parsename('filezilla.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Start Men&u'}
if ($verb) {$verb.DoIt()}

Write-Host "FileZilla silent installation and pining to startmenu completed"