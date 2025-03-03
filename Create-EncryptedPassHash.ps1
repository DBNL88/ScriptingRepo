# Command voor het genereren van een encrypted password-hash. 

"wachtwoord" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "C:\Automation-Scripts\password.sec"


