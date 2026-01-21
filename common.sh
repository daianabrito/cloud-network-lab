#!/bin/bash
set -e
echo "[+] Updating system"
apt update -y
apt upgrade -y
echo "[+] Installing common packages"
apt install -y curl git ufw net-tools dnsutils python3 python3-pip
