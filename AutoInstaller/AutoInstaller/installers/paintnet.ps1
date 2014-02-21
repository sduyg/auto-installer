Write-Host "starting download, unzip and silent install of Paint.NET"

&md -Path 'C:\MyInstaller\PaintNet'

$paintNetsetupsPath = "C:\MyInstaller\PaintNet" 
$paintNetunzipPath = "$paintNetsetupsPath\paint-net"
$paintNetzip = "$paintNetsetupsPath\paint-net.zip" 
$urlpaintNet = "http://www.dotpdn.com/files/Paint.NET.3.5.11.Install.zip"

if ((Test-Path -path $paintNetunzipPath) -eq $False) 
{ 
    md $paintNetunzipPath
}


Write-Host "downloading paint.net"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlpaintNet,$paintNetzip)

Write-Host "unzipping paint.net"

$shell = New-Object -com shell.application 
$destination = $shell.namespace($paintNetunzipPath) 
$destination.Copyhere($shell.namespace($paintNetzip).items())

Remove-Item $paintNetzip -recurse -force

Write-Host "silent installing paint.net"

& $paintNetunzipPath\Paint.NET.3.5.11.Install.exe /auto

$paintNetExeFile = "C:\Program Files\Paint.NET\PaintDotNet.exe"

While (1 -eq 1) {
    IF (Test-Path $paintNetExeFile) {
        break
    }
}


Write-Host "just waiting 30 sec more"

Start-Sleep -s 30

Write-Host "pining paint.net to start menu"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files\Paint.NET')    
$item = $folder.Parsename('PaintDotNet.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Start Men&u'}
if ($verb) {$verb.DoIt()}


Write-Host "paint.net silent installation and pining to startmenu completed"