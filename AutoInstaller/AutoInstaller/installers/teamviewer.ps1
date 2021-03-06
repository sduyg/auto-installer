Write-Host "starting download and silent install of TeamViewer"

&md -Path 'C:\MyInstaller\TeamViewer'

$teamViewerPath = "C:\MyInstaller\TeamViewer" 
$teamViewerSetupPath = "C:\MyInstaller\TeamViewer\TeamViewer_Setup_tr-ckq.exe" 

$urlteamViewer = "http://downloadus1.teamviewer.com/download/TeamViewer_Setup_tr-ckq.exe"

Write-Host "downloading teamviewer"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlteamViewer,$teamViewerSetupPath)

Write-Host "silent installing teamviewer"

& $teamViewerPath\TeamViewer_Setup_tr-ckq.exe /S

Write-Host "pining teamViewer to start menu"

$teamViewerExeFile = "C:\Program Files (x86)\TeamViewer\Version9\TeamViewer.exe"

While (1 -eq 1) {
    IF (Test-Path $teamViewerExeFile) {
        break
    }
}


Write-Host "pining teamViewer to start menu"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\TeamViewer\Version9')    
$item = $folder.Parsename('TeamViewer.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Start Men&u'}
if ($verb) {$verb.DoIt()}


Write-Host "teamViewer silent installation and pining to start menu completed"