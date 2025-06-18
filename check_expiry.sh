#!/bin/bash
echo "[*] Memeriksa kadaluarsa sertifikat:"
for crt in certs/*.crt; do
    echo -n "$crt: "
    openssl x509 -in "$crt" -noout -enddate
done
