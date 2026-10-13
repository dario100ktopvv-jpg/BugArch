@echo off
setlocal
echo ==========================================
echo    BugArch OS - Windows Wrapper Setup    
echo ==========================================

:: Controllo file di sistema Windows
if exist "C:\Windows\System32\cmd.exe" if exist "C:\Windows\notepad.exe" (
    echo [+] Ambiente Windows confermato.
) else (
    echo [!] Errore: Questo script deve essere eseguito su Windows.
    pause
    exit /b 1
)

:: Ricerca Git Bash
set "GITBASH=C:\Program Files\Git\bin\bash.exe"
if not exist "%GITBASH%" set "GITBASH=C:\Program Files (x86)\Git\bin\bash.exe"
if not exist "%GITBASH%" set "GITBASH=%LocalAppData%\Programs\Git\bin\bash.exe"

if not exist "%GITBASH%" (
    echo [!] Git Bash non trovato nei percorsi standard.
    pause
    exit /b 1
)

:: Pulizia dei vecchi .bat escludendo rigorosamente questo script in esecuzione
echo [*] Pulizia dei vecchi wrapper...
for %%f in (*.bat) do (
    if /i not "%%~nxf"=="%~nx0" (
        del "%%f"
    )
)

set "COMMANDS=pcs rslvbg deta restheal recho reebota syinfo wipwd"

echo [*] Generazione dei nuovi wrapper .bat...
for %%c in (%COMMANDS%) do (
    echo @echo off > "%%c.bat"
    echo "%GITBASH%" "%%~dp0%%c" %%* >> "%%c.bat"
    echo   - Generato: %%c.bat
)

echo.
echo [OK] Fatto!
echo ==========================================
pause