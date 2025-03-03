<# script voor het genereren van een encrypted password-hash. 

Voorbeeld script hoe output te gebruiken:


$scriptPath = "C:\Automation-Scripts"
$taskUser = "DOMAIN1\AT"
$passwordFile = "C:\Automation-Scripts\password.sec"

# Wachtwoord laden en converteren naar plain-text (LET OP: werkt alleen voor dezelfde gebruiker en machine)
$taskPassword = Get-Content $passwordFile | ConvertTo-SecureString
$taskPasswordPlain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($taskPassword)
)

$startTime = "08:00"  # Pas aan naar gewenste starttijd (HH:MM)
$frequency = "DAILY"  # Mogelijke opties: DAILY, WEEKLY, HOURLY, ONCE
$taskRunLevel = "Highest"

# Loop door alle .ps1-bestanden in de map
Get-ChildItem -Path $scriptPath -Filter "*.ps1" | ForEach-Object {
    $scriptName = $_.BaseName
    $scriptFullPath = $_.FullName
    $taskName = "Run_$scriptName"

    # Command dat de taak uitvoert (PowerShell)
    $taskCommand = "powershell.exe -ExecutionPolicy Bypass -File `"$scriptFullPath`""

    # Verwijder bestaande taak als die al bestaat
    schtasks /Delete /TN "$taskName" /F 2>$null

    # Maak de nieuwe taak aan met correcte parameters
    schtasks /Create /TN "$taskName" /TR "$taskCommand" /SC $frequency /ST $startTime /RU "$taskUser" /RP "$taskPasswordPlain" /RL $taskRunLevel /IT /F

    Write-Host "Scheduled Task aangemaakt: $taskName"
}

Write-Host "Alle taken zijn succesvol aangemaakt!"
#>


"wachtwoord" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "C:\Automation-Scripts\password.sec"


