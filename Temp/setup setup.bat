@echo off
set /p IPAddr=Bitte gib die gewünschte IP-Adresse ein: 
set /p Gateway=Bitte gib das Standard-Gateway ein: 

netsh interface ipv4 set address "Ethernet" static %IPAddr% 255.255.255.0 %Gateway% 1

netsh interface ipv4 set dnsservers "Ethernet" static 8.8.8.8 primary
netsh interface ipv4 add dnsservers "Ethernet" 8.8.4.4 index=2

echo Die IP-Adresse, Subnetzmaske, Standard-Gateway und DNS wurden erfolgreich eingestellt.


start "Mein Programm" "C:\Programme\MeinProgramm.exe"
ren "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" BBBMicrosoftEdgeUpdateB.exe
cls

:: Deaktiviere Microsoft Store-Updates
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v AutoDownload /t REG_DWORD /d 2 /f

:: Starte den Windows Update-Dienst neu
net stop wuauserv
net start wuauserv
echo Microsoft Store-Updates wurden deaktiviert.


:: Moved autostart updater
move "autostart.bat" "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

pip install -r requirements.txt
mkdir %APPDATA%\gspread
cd C:\Users\%USERNAME%\Desktop\Installations\R
move service_account.json C:\Users\%USERNAME%\AppData\Roaming\gspread

:: Python Installieren
powershell -Command "& { iwr 'https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe' -OutFile 'python-3.11.4-amd64.exe' }"
python-3.11.4-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 InstallLauncherAllUsers=1 TargetDir=%USERPROFILE%\Python3114
setx path "%PATH%;%USERPROFILE%\Python3114;%USERPROFILE%\Python3114\Scripts" /M
:: VSCode Installieren
powershell -Command "& { iwr 'https://aka.ms/win32-x64-user-stable' -OutFile 'VSCodeSetup.exe' }"
VSCodeSetup.exe /verysilent /mergetasks=!runcode

:: Aktiviert Windows
cls
slmgr /upk
slmgr.vbs /cpky
slmgr /ckms
slmgr.vbs /ckms
slmgr /skms localhost
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr /skms kms.digiboy.ir
slmgr /ato

