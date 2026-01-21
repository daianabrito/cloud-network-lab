#!/bin/bash
set -e

# Executa common
../../common.sh

# Instala PostgreSQL
apt install -y postgresql postgresql-contrib

# Configura DB e usuário
sudo -u postgres psql -c "CREATE USER app WITH PASSWORD 'secret';"
sudo -u postgres psql -c "CREATE DATABASE lab OWNER app;"

# Configura firewall
../../firewall/firewall.sh db

echo "[+] DB ready"
