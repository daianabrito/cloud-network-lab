#!/bin/bash
set -e

echo "[+] Running common setup"
# common.sh já cuida do apt update, apt upgrade e pacotes básicos
bash ../../common.sh

echo "[+] Installing PostgreSQL"
sudo apt install -y postgresql postgresql-contrib

echo "[+] Starting PostgreSQL service"
sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "[+] Creating test database and user"
sudo -u postgres psql -c "CREATE DATABASE labdb;"
sudo -u postgres psql -c "CREATE USER labuser WITH ENCRYPTED PASSWORD 'labpass';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE labdb TO labuser;"

echo "[+] Configuring firewall for DB access (App VM only)"
# Exemplo usando ufw: permitir apenas a subnet 10.0.1.0/24 (App VM)
sudo ufw allow from 10.0.1.0/24 to any port 5432 proto tcp
sudo ufw --force enable

echo "[+] Setting up Python virtual environment"
cd ~
python3 -m venv venv
# ativa o venv para instalar pacotes
source venv/bin/activate

echo "[+] Installing Python DB driver"
pip install --upgrade pip
pip install psycopg2-binary

echo "[+] Creating log directory for scripts"
mkdir -p ~/db_logs
chmod 755 ~/db_logs

echo "[+] DB VM setup completed!"
echo "[+] Python venv: ~/venv"
echo "[+] Logs: ~/db_logs"

###
#Notas importantes

#PEP 668 / venv: não instala pacotes Python globalmente, evita problemas com pip install no Ubuntu 24+.

#Logs e diretórios: criei ~/db_logs com permissões corretas para o usuário, assim scripts Python podem escrever lá sem root.

#Firewall: liberando somente a subnet da App VM (10.0.1.0/24) para PostgreSQL (porta 5432).

#Sudo: usado apenas onde necessário (apt, systemctl, ufw, psql como postgres).