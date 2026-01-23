#!/bin/bash
set -e

echo "[+] Running common setup"
# Executa common.sh com sudo, caso ainda precise instalar pacotes básicos
bash ../../common.sh

echo "[+] Creating app directory"
sudo mkdir -p /opt/app
sudo cp -r ../app/* /opt/app/
sudo chown -R labuser:labuser /opt/app

echo "[+] Setting up Python virtual environment"
cd /opt/app
python3 -m venv venv
# ativa o venv para instalar pacotes
source venv/bin/activate

echo "[+] Installing Python dependencies in venv"
pip install --upgrade pip
pip install flask psycopg2-binary

echo "[+] Starting application"
# Garante que a VM possa rodar o app em background com logs
LOGFILE=~/app.log
nohup /opt/app/venv/bin/python /opt/app/main.py > "$LOGFILE" 2>&1 &

echo "[+] App started successfully"
echo "[+] Logs available at $LOGFILE"
