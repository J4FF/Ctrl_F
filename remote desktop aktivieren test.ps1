# Aktiviere Remote-Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

# Starte den Remote-Desktop-Dienst neu
Restart-Service -Name TermService
