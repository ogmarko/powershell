$To = "user@server.com"
$From = "sysadmin@server.com" 
$Subject = "Expired Accounts" 
$SMTPServer = "mail.server.com" 
$Today = Get-Date
$ExpiredAccounts = search-adaccount -AccountExpiring -TimeSpan "1" | Select-Object Name,AccountExpirationDate | Out-String

If ($ExpiredAccounts -eq '')
{
   
} 
Else 
{ 
   
   Send-MailMessage -To $To -From $From -Subject $Subject -Body "The following account(s) expire today. Please disable email access for: 
$ExpiredAccounts
   

   "   -SMTPServer $SMTPServer 
} 

