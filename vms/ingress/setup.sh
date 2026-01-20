#!/bin/bash
# setup.sh - Ingress VM
# Run as a user with sudo privileges

set -e  # Exit immediately if a command exits with a non-zero status

echo "== Updating system =="
sudo apt update -y
sudo apt upgrade -y

echo "== Installing Nginx =="
sudo apt install -y nginx

echo "== Configuring firewall (UFW) =="
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw --force enable

echo "== Copying Nginx configuration =="
sudo cp ~/cloud-network-lab/vms/ingress/nginx/ingress.conf \
        /etc/nginx/sites-available/ingress.conf

echo "== Enabling site =="
sudo ln -sf /etc/nginx/sites-available/ingress.conf \
            /etc/nginx/sites-enabled/ingress.conf

echo "== Disabling default site =="
sudo rm -f /etc/nginx/sites-enabled/default

echo "== Testing Nginx configuration =="
sudo nginx -t

echo "== Restarting Nginx =="
sudo systemctl restart nginx

echo "✅ Ingress VM successfully configured"
