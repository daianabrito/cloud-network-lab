#!/bin/bash
set -e

# Executa common
../../common.sh

# Instala Python e dependências
pip3 install flask psycopg2-binary

# Cria diretório da aplicação
mkdir -p /opt/app
cp -r ../../app/* /opt/app/

# Start app
nohup python3 /opt/app/main.py > /var/log/app.log 2>&1 &
echo "[+] App started"
