Write-Host "starting download, silent install of sublimetext"

&md -Path 'C:\MyInstaller\SublimeText'

$sublimeSetupsPath = "C:\MyInstaller\SublimeText" 
$sublimeunzipPath = "$sublimeSetupsPath\Sublime Text 2.0.2 x64"
$sublimezip = "$sublimeSetupsPath\Sublime Text 2.0.2 x64.zip" 
$urlsublime = "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.zip"

if ((Test-Path -path $sublimeunzipPath) -eq $False) 
{ 
    md $sublimeunzipPath
}


Write-Host "downloading sublime"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlsublime,$sublimezip)

Write-Host "unzipping sublime"

$shell = New-Object -com shell.application 
$destination = $shell.namespace($sublimeunzipPath) 
$destination.Copyhere($shell.namespace($sublimezip).items())

Remove-Item $sublimezip -recurse -force


$sublimeExeFile = "C:\MyInstaller\SublimeText\Sublime Text 2.0.2 x64\sublime_text.exe"

Write-Host "pining sublime to task bar"

While (1 -eq 1) {
    IF (Test-Path $sublimeExeFile) {
        break
    }
}

Write-Host "pining sublime to TaskBar"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\MyInstaller\SublimeText\Sublime Text 2.0.2 x64')    
$item = $folder.Parsename('sublime_text.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb) {$verb.DoIt()}

Write-Host "installation and pining sublime to taskBar completed"