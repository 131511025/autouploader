Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$baseDir = "D:\share\"
$folderTarget = "Folder"

### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $baseDir + $folderTarget
$watcher.Filter = "*"

### DEFINE ACTIONS AFTER A EVENT IS DETECTED
$logPath = $baseDir + "Log\log_watcher.log"

$action = { 
	$path = $Event.SourceEventArgs.FullPath
	$logline = "$(Get-Date), Processed, $path"
	$command = $baseDir + "uploader.bat"
	Add-content $logPath -value $logline
	cmd.exe /c $command
}
	  
### DECIDE WHICH EVENTS SHOULD BE WATCHED + SET CHECK FREQUENCY  
$created = Register-ObjectEvent $watcher "Created" -Action $action
while ($true) {sleep 1}	