import requests

url = "https://localhost/"
response = requests.get(
    url,
    cert=("certs/client.crt", "certs/client.key"),
    verify="certs/rootCA.pem"
)

print(response.status_code, response.json())
