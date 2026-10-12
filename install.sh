#!/bin/bash

echo "=========================================="
echo "    BugArch OS - Universal Installer     "
echo "=========================================="

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || -n "$WINDIR" ]]; then
    echo "[*] Rilevato ambiente Windows (Git Bash/MSYS2)."
    if [ -f "make_bats.bat" ]; then
        echo "[*] Generazione dei wrapper .bat..."
        cmd.exe /c "make_bats.bat"
    fi
else
    echo "[*] Rilevato ambiente Linux."
    echo "[*] Impostazione dei permessi di esecuzione..."
    chmod +x pcs rslvbg deta syinfo 2>/dev/null
    
    echo "[*] Copia dei comandi in /usr/local/bin..."
    sudo cp pcs rslvbg deta syinfo /usr/local/bin/ 2>/dev/null || cp pcs rslvbg deta syinfo /usr/local/bin/
    
    echo "[OK] Installazione completata per Linux!"
fi
