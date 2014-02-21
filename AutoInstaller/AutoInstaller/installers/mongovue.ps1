Write-Host "starting download and silent install of MongoVue"

&md -Path 'C:\MyInstaller\MongoVue'

$mongoDbPath = "C:\MyInstaller\MongoVue" 
$urlMongoVue = "http://www.mongovue.com/Installer-1.6.9.zip"
$zipFileMongoVue = "$mongoDbPath\Installer-1.6.9.zip" 
$unzippedFolderContentMongoVue = "$mongoDbPath\Installer-1.6.9"

Write-Host "downloading MongoVue"

$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($urlMongoVue,$zipFileMongoVue)

Write-Host "unzipping MongoVue"
 
$shellApp = New-Object -com shell.application 
$destination = $shellApp.namespace($mongoDbPath) 
$destination.Copyhere($shellApp.namespace($zipFile).items())
 
Copy-Item "$unzippedFolderContentMongoVue\*" $mongoDbPath -recurse
 
Remove-Item $unzippedFolderContentMongoVue -recurse -force 
Remove-Item $zipFileMongoVue -recurse -force

Write-Host "silent installing MongoVue"

$installerFilePathMongoVue = "C:\MongoVue\Installer.msi"
&msiexec /i $installerFilePathMongoVue /qn

$mongoVueExeFile = "C:\Program Files (x86)\MongoVUE\MongoVUE 1.6.9\MongoVUE.exe"


Write-Host "pining MongoVue to taskBar"

While (1 -eq 1) {
    IF (Test-Path $mongoVueExeFile) {
        #file exists. break loop
        break
    }
}

$shell = new-object -com "Shell.Application"  
$folder = $shell.Namespace('C:\Program Files (x86)\MongoVUE\MongoVUE 1.6.9')    
$item = $folder.Parsename('MongoVUE.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb) {$verb.DoIt()}

Write-Host "MongoVue silent installation and pining to taskbar completed"