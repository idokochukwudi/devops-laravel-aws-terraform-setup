#!/bin/bash
# Node.js Worker EC2 Setup Script for Amazon Linux 2023

set -e

# Update system and install required packages
dnf update -y
dnf install -y git nginx

# Install Node.js 18
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
dnf install -y nodejs

# Create app directory and clone app
APP_DIR="/home/ec2-user/node-worker"
if [ ! -d "$APP_DIR" ]; then
  git clone https://github.com/idokochukwudi/node-worker-app.git $APP_DIR
fi

# Change ownership
chown -R ec2-user:ec2-user $APP_DIR
cd $APP_DIR

# Install app dependencies
sudo -u ec2-user npm install

# Install PM2 globally
npm install -g pm2

# Start app with PM2
sudo -u ec2-user pm2 start index.js --name node-worker
sudo -u ec2-user pm2 save
sudo -u ec2-user pm2 startup systemd -u ec2-user --hp /home/ec2-user

# Set up Nginx reverse proxy
cat <<EOF > /etc/nginx/conf.d/node-worker.conf
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Remove default site and restart Nginx
rm -f /etc/nginx/conf.d/default.conf
nginx -t && systemctl enable nginx && systemctl restart nginx

echo "✅ Node.js worker with Nginx reverse proxy setup complete."
