#!/bin/bash

echo "[*] Memeriksa tanggal kadaluarsa..."
expiry_date=$(openssl x509 -enddate -noout -in certs/server.crt | cut -d= -f2)
expiry_ts=$(date -j -f "%b %e %T %Y %Z" "$expiry_date" "+%s")
now_ts=$(date "+%s")

# Jika masa berlaku tinggal < 7 hari, perpanjang
if (( (expiry_ts - now_ts) < 604800 )); then
    echo "[!] Sertifikat akan kadaluarsa dalam 7 hari. Memperpanjang..."
    ./generate_certs.sh 30
    docker-compose restart
else
    echo "[OK] Sertifikat masih berlaku."
fi
