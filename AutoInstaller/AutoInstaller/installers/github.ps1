Write-Host "starting download, unzip and silent install of github"

$githubPath = "C:\Users\Yazılım\Desktop\SlientInstall\GitHub"
$setupsPath = "D:\Setup\GitHubSetup.exe"
 
$url = "https://github-windows.s3.amazonaws.com/GitHubSetup.exe"




Write-Host "downloading github"
$webClient = New-Object System.Net.WebClient 
$webClient.DownloadFile($url,$setupspath)





Write-Host "silent installing github"
& $setupspath \GitHubSetup.exe /v