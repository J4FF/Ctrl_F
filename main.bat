@echo off
set /p IPAddr=Bitte gib die gewünschte IP-Adresse ein: 
set /p Gateway=Bitte gib das Standard-Gateway ein: 

netsh interface ipv4 set address "Ethernet" static %IPAddr% 255.255.255.0 %Gateway% 1

netsh interface ipv4 set dnsservers "Ethernet" static 8.8.8.8 primary
netsh interface ipv4 add dnsservers "Ethernet" 8.8.4.4 index=2

echo Die IP-Adresse, Subnetzmaske, Standard-Gateway und DNS wurden erfolgreich eingestellt.
pause
