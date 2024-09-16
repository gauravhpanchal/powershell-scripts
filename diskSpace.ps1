$Threshold = 10
$Drives = Get-PSDrive -PSProvider FileSystem
$MailAccount = Import-Clixml -Path "C:\Scripts\SendEmail\outlook.xml"
$MailSMTPServer = "smtp-mail.outlook.com"
$MailPort = 587
$MailFrom = $MailAccount.Username
$MailTo = "gauravhpanchal2@gmail.com"

foreach ($Drive in $Drives) {
    $FreeSpacePercent = ($Drive.Free / $Drive.Used) * 100
    if ($FreeSpacePercent -lt $Threshold) {
        $Subject = "Low Disk Space Alert: $($Drive.Name)"
        $Body = "Drive $($Drive.Name) is running low on space. Free space: $([math]::round($FreeSpacePercent, 2))%."
        Send-MailKitMessage -From $MailFrom -To $MailTo -SMTPServer $MailSMTPServer -Port $MailPort -Credential $MailAccount -Subject $Subject -Body $Body
    }
}
