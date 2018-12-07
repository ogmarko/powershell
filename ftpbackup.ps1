Import-Module PSTerminalServices

$today = Get-Date
$day = $today.ToString('MMddyyyy')
$folder = "Z:\" + $day 
$file = "Z:\" + $day + ".zip"

echo "Backing up files to" + $file

set-alias sz "$env:ProgramFiles\7-zip\7z.exe"

New-Item $folder -type directory

Foreach ($element in Dir C:\fm) {
	if ($element.Extension -eq ".fmp12") {
		Copy-Item $element.fullname $folder
	}
}
sz a -tzip $file $folder

echo "Uploading $day.zip..."

$destination = "ftp://ftp.server.com/" + $day + ".zip"
$user = "USER"
$pass = "PASSWORD"
$webclient = New-Object System.Net.WebClient
$webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
$webclient.UploadFile($destination, $file)
$webclient.Dispose()


echo "Removing disconnected users...."
$Sessions = get-tssession | where {(($_.state -eq "Disconnected") -and ($_.useraccount -ne "WIN-D998G4QBV9B\Administrator") -and ($_.sessionID -ne "0"))}
foreach($session in $Sessions){ logoff $session.sessionid }

echo "Deleting $file"
Remove-Item $file -Force -recurse
Remove-Item $folder -Force -recurse