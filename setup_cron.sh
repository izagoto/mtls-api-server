#!/bin/bash

# Path absolut ke script renew_certs.sh
RENEW_SCRIPT_PATH="$(pwd)/renew_certs.sh"

# Buat cronjob entri dan simpan ke file sementara
cat <<EOF > cronjob.txt
# Cronjob untuk auto-rotasi sertifikat setiap jam 1 pagi
0 1 * * * $RENEW_SCRIPT_PATH >> /tmp/cert_renew.log 2>&1
EOF

# Install cronjob
crontab cronjob.txt
rm cronjob.txt

echo "[✔] Cronjob telah di-setup. Cek dengan: crontab -l"
