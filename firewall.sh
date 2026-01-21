#!/bin/bash
set -e
ROLE=$1

ufw --force reset
ufw default deny incoming
ufw default allow outgoing

if [ "$ROLE" = "ingress" ]; then
    ufw allow 80/tcp
    ufw allow 443/tcp
elif [ "$ROLE" = "app" ]; then
    ufw allow from 10.0.0.0/24 to any port 8000 proto tcp
elif [ "$ROLE" = "db" ]; then
    ufw allow from 10.0.1.0/24 to any port 5432 proto tcp
fi

ufw --force enable
echo "[+] Firewall configured for role: $ROLE"
