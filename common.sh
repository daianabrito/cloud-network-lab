#!/bin/bash
set -e

echo "[+] Updating system"
sudo apt update -y
sudo apt upgrade -y

echo "[+] Installing common packages"
sudo apt install -y curl git ufw net-tools dnsutils python3 python3-venv python3-pip

echo "[+] Common Python setup"
# cria diretório para venv global do usuário, só se quiser
mkdir -p ~/venvs
# opcional: criar um venv base
python3 -m venv ~/venvs/base
source ~/venvs/base/bin/activate
pip install --upgrade pip
