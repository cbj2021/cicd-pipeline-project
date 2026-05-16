#!/usr/bin/env bash
# Run once on a fresh Ubuntu VPS
set -e
echo "==> Updating packages..."
apt update && apt upgrade -y
echo "==> Installing Docker, Nginx, Certbot..."
apt install -y docker.io nginx certbot python3-certbot-nginx ufw
systemctl enable docker && systemctl start docker
echo "==> Configuring firewall..."
ufw allow OpenSSH
ufw allow 'Nginx Full'
ufw --force enable
echo ""
echo "Done! Next steps:"
echo "  1. Copy nginx/default.conf to /etc/nginx/sites-available/my-app"
echo "  2. Edit server_name with your domain"
echo "  3. ln -s /etc/nginx/sites-available/my-app /etc/nginx/sites-enabled/"
echo "  4. nginx -t && systemctl reload nginx"
echo "  5. certbot --nginx -d yourdomain.com"
