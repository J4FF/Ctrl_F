@echo off
setlocal

sc stop wuauserv
sc config wuauserv start= disabled

rem Setzen Sie den Dateinamen und den GitHub-API-Link
set "filename=main.py"
set "github_api_url=https://raw.githubusercontent.com/J4FF/Ding-Points-3.0/main/%filename%"

rem Setzen Sie Ihren persönlichen Zugriffstoken (ohne Anführungszeichen)
set "access_token=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"

rem Definieren Sie den Speicherort für die heruntergeladene Datei
set "output_path=%USERPROFILE%\Desktop\Bing\%filename%"

rem Herunterladen der Datei mit curl und speichern im angegebenen Verzeichnis
curl -H "Authorization: token %access_token%" -o "%output_path%" -L %github_api_url%

echo Datei wurde heruntergeladen nach %output_path%

rem Führen Sie die Python-Datei aus
cd %USERPROFILE%\Desktop\Bing\

python main.py

endlocal
