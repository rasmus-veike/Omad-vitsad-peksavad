
$Date = Get-Date -Format "yyyyMMdd_HHmmss"
$BackupFile = "C:\Backups\RasmusVeike_$Date.sql"
# sqlcmd -S localhost -U sa -P MyPassword -Q "BACKUP DATABASE [MyDatabase] TO DISK='$BackupFile'"

# mysqldump -u root -pMyPassword mydatabase > $BackupFile

# Testiks lihtsalt tühi fail:
"See oleks andmebaasi varukoopia" | Out-File -FilePath $BackupFile -Encoding utf8

Write-Output "Backup loodud: $BackupFile"

# Kasutame WinSCP .NET assembly (vajab WinSCP)

Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"

$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Sftp
    HostName = "172.18.24.8"
    UserName = "backups"
    Password = "Passw0rd"
    SshHostKeyPolicy = "GiveUpSecurityAndAcceptAny"
}

$session = New-Object WinSCP.Session
try {
    $session.Open($sessionOptions)
    $remotePath = "/C:/Users/backups/databases/" + [IO.Path]::GetFileName($BackupFile)
    $session.PutFiles($BackupFile, $remotePath).Check()
    Write-Output "Fail saadetud serverisse: $remotePath"
}
finally {
    $session.Dispose()
}
