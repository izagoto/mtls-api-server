
# 🔐 mTLS API Server (FastAPI + NGINX + Docker)

API Server dengan Autentikasi Dua Arah (Mutual TLS) untuk validasi identitas client & server menggunakan sertifikat digital.  
Dirancang untuk komunikasi **lebih aman dari Bearer Token / API Key** biasa.

---

## 📌 Fitur Utama

✅ Autentikasi mTLS 2 arah  
✅ FastAPI sebagai backend  
✅ NGINX sebagai reverse proxy + validasi client cert  
✅ Logging & audit identitas client  
✅ Rotasi otomatis sertifikat (cron)  
✅ Monitoring expiry sertifikat

---

## 🚀 Menjalankan Project

### 1. 🔐 Generate Sertifikat

```bash
./generate_certs.sh 30
```

### 2. 🐳 Jalankan Docker

```bash
docker-compose up --build
```

Akses API via:  
📫 `https://localhost/`

### 3. 🔍 Tes Client mTLS

```bash
curl https://localhost/   --cert certs/client.crt   --key certs/client.key   --cacert certs/rootCA.pem
```

---

## 🧠 Rotasi Sertifikat Otomatis

Cek masa berlaku setiap hari, dan regenerate jika tinggal < 7 hari.

```bash
./renew_certs.sh
```

Tambahkan ke cronjob (macOS/Linux):
```cron
0 2 * * * /path/to/renew_certs.sh >> /tmp/cert_renew.log 2>&1
```

---

## 📜 Audit Logging

Lokasi log client mTLS:
```
logs/mtls_access.log
```

Contoh log:
```
192.168.1.10 - - [18/Jun/2025:22:00:00 +0000] "GET / HTTP/1.1" 200 ... ssl_client_subject=CN=mtls-client
```

---

## 📦 Sertifikat

| File | Fungsi |
|------|--------|
| `client.crt` / `client.key` | Sertifikat & key client |
| `server.crt` / `server.key` | Sertifikat & key server |
| `rootCA.pem` | CA yang ditandatangani client & server |
| `client.p12` | Sertifikat client dalam satu file (.p12) |

---

## ✅ Best Practices

- 🛡 Simpan `.p12` di Secrets Manager
- 🔁 Rotasi sertifikat rutin (<= 30 hari)
- 📋 Aktifkan audit log sertifikat client
- 🧹 Hapus sertifikat sementara setelah penggunaan

---

## 📚 Referensi

- [FastAPI](https://fastapi.tiangolo.com/)
- [OpenSSL PKI](https://wiki.openssl.org/index.php/Creating_a_Private_CA)
- **NGINX SSL Module** (ssl_client_certificate, ssl_verify_client, ssl_protocols) :contentReference[oaicite:8]{index=8}
- **Smallstep: Configuring Nginx Server for Mutual TLS** :contentReference[oaicite:9]{index=9}
- [RFC 8446 TLS 1.3](https://datatracker.ietf.org/doc/html/rfc8446)


---

## 📄 License

This project is licensed under the [MIT License](./LICENSE) — feel free to use and learn from it!

..