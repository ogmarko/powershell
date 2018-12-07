$To = "user@server.com"
$From = "sysadmin@server.com" 
$Subject = "30 day accounts with no logon" 
$SMTPServer = "mail.server.com" 


$inactiveDomain = search-adaccount -accountinactive -usersonly -timespan "30" | where { (($_.DistinguishedName -like "CN=*,OU=USERS,DC=domain,DC=com") -and ($_.Enabled -eq "True") -and ($_.LastLogonDate -ne $null))} | Select-Object Name,DistinguishedName,LastLogonDate | Out-String -Width 200

If  ($inactiveDomain-eq ''))
{
   
} 
Else 
{ 
   
   Send-MailMessage -To $To -From $From -Subject $Subject -Body "The following accounts will be disabled 

Domain
	$inactiveDomain
   

   "   -SMTPServer $SMTPServer 
} 