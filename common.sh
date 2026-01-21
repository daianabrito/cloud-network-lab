#!/bin/bash
set -e
echo "[+] Updating system"
sudo apt update -y
sudo apt upgrade -y
echo "[+] Installing common packages"
sudo apt install -y curl git ufw net-tools dnsutils python3 python3-pip
