set -e

DAYS=${1:-30}

mkdir -p certs
cd certs

echo "[*] Membuat Root CA..."
openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.pem -subj "/CN=MyRootCA"

echo "[*] Membuat sertifikat server (valid $DAYS hari)..."
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -subj "/CN=localhost"
openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days "$DAYS" -sha256

echo "[*] Membuat sertifikat client (valid $DAYS hari)..."
openssl genrsa -out client.key 2048
openssl req -new -key client.key -out client.csr -subj "/CN=mtls-client"
openssl x509 -req -in client.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out client.crt -days "$DAYS" -sha256

openssl pkcs12 -export -inkey client.key -in client.crt -certfile rootCA.pem -out client.p12 -passout pass:

echo "[✔] Sertifikat dibuat. Masa berlaku: $DAYS hari"
