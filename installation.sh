#!/bin/bash

AUTO_YES=false
AUTO_NO=false
QUIET=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -Y) AUTO_YES=true; shift ;;
        -N) AUTO_NO=true; shift ;;
        -Q) QUIET=true; shift ;;
        -*) echo "Opzione non valida: $1" >&2; exit 1 ;;
        *) shift ;;
    esac
done

if [ "$AUTO_NO" = true ]; then
    [ "$QUIET" = false ] && echo "Installazione annullata per flag -N."
    exit 0
fi

if [ "$AUTO_YES" = false ] && [ "$QUIET" = false ]; then
    read -p "Vuoi procedere con l'installazione di BugArch OS sul sistema? [s/N]: " confirm
    [[ "$confirm" =~ ^[sS]$ ]] || { echo "Installazione interrotta."; exit 0; }
fi

# Lista dei binari di BugArch OS
BINARIES=("pcs" "rslvbg" "deta" "restheal" "recho" "reebota" "syinfo" "wipwd")

if [ "$QUIET" = false ]; then
    echo "[*] Preparazione installazione binari..."
fi

# Rendi eseguibili tutti i file locali
for bin in "${BINARIES[@]}"; do
    if [ -f "$bin" ]; then
        chmod +x "$bin"
        [ "$QUIET" = false ] && echo "  -> $bin reso eseguibile."
    fi
done

# Tentativo di installazione globale in /usr/local/bin (richiede privilegi)
INSTALL_DIR="/usr/local/bin"
if [ -d "$INSTALL_DIR" ] && [ -w "$INSTALL_DIR" ]; then
    for bin in "${BINARIES[@]}"; do
        if [ -f "$bin" ]; then
            cp "$bin" "$INSTALL_DIR/"
        fi
    done
    [ "$QUIET" = false ] && echo "[OK] BugArch OS installato con successo in $INSTALL_DIR!"
else
    [ "$QUIET" = false ] && echo "[*] Impossibile scrivere in $INSTALL_DIR (permessi insufficienti)."
    [ "$QUIET" = false ] && echo "[*] I comandi possono essere eseguiti direttamente da questa cartella."
fi

if [ "$QUIET" = true ]; then
    echo "INSTALLED: SUCCESS"
fi