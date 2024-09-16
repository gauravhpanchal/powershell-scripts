$Services = Get-Service | Select-Object Name, Status
$ReportPath = "C:\Reports\ServiceStatus_$(Get-Date -Format 'yyyyMMdd').txt"
$MailAccount = Import-Clixml -Path "C:\Scripts\SendEmail\outlook.xml"
$MailSMTPServer = "smtp-mail.outlook.com"
$MailPort = 587
$MailFrom = $MailAccount.Username
$MailTo = "gauravhpanchal2@gmail.com"

$Services | Out-File -FilePath $ReportPath

$Subject = "Daily Service Status Report"
$Body = "Attached is the service status report for $((Get-Date).ToString('yyyy-MM-dd'))."
$Attachment = $ReportPath
Send-MailKitMessage -From $MailFrom -To $MailTo -SMTPServer $MailSMTPServer -Port $MailPort -Credential $MailAccount -Subject $Subject -Body $Body -Attachments $Attachment
