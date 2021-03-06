Write-Host "starting download and install ColorPix"

&md -Path 'C:\MyInstaller\ColorPix'

$urlColorPix = "http://www.colorschemer.com/ColorPix.exe"
$colorPixSetupsPath = "C:\MyInstaller\ColorPix\ColorPix.exe" 

Write-Host "downloading colorPix"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlColorPix, $colorPixSetupsPath)

While (1 -eq 1) {
    IF (Test-Path $colorPixSetupsPath) {
        break
    }
}


Write-Host "pining colorPix to start menu"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\MyInstaller\ColorPix')    
$item = $folder.Parsename('ColorPix.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Start Men&u'}
if ($verb) {$verb.DoIt()}

Write-Host "coloPix installation and pining to start menu completed"