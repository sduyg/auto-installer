Write-Host "starting download and silent install of Graphviz"

&md -Path 'C:\MyInstaller\Graphviz'

$urlgraphviz = "http://www.graphviz.org/pub/graphviz/stable/windows/graphviz-2.30.1.msi"
$graphvizPath = "C:\MyInstaller\Graphviz"
$graphvizSetupPath = "C:\MyInstaller\Graphviz\graphviz-2.30.1.msi" 

Write-Host "downloading Graphviz"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlgraphviz, $graphvizSetupPath)

Write-Host "silent installing Graphviz"

&msiexec /i $graphvizSetupPath /qn

$graphvizExeFile = "C:\Program Files (x86)\Graphviz2.30\bin\gvedit.exe"

While (1 -eq 1) {
    IF (Test-Path $graphvizExeFile) {
        break
    }
}

Write-Host "pining Graphviz to start menu"

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\Graphviz2.30\bin')    
$item = $folder.Parsename('gvedit.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Start Men&u'}
if ($verb) {$verb.DoIt()}

Write-Host "Graphviz silent installation and pining to startmenu completed"