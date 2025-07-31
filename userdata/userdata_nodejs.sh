#!/bin/bash

# Enable logging to /var/log/install.log
exec > /var/log/install.log 2>&1
set -e

echo "Updating system packages..."
sudo dnf update -y

echo "Removing conflicting curl-minimal package if exists..."
sudo dnf remove -y curl-minimal || true

echo "Installing curl with allowerasing to fix conflicts..."
sudo dnf install -y curl --allowerasing

echo "Installing nginx with allowerasing..."
sudo dnf install -y nginx --allowerasing

echo "Starting and enabling nginx service..."
sudo systemctl start nginx
sudo systemctl enable nginx

echo "Installing Node.js 18.x and build tools..."
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo dnf install -y nodejs gcc-c++ make

echo "Installing PM2 globally..."
sudo npm install -g pm2

APP_DIR="/home/ec2-user/node-app"
echo "Creating application directory at $APP_DIR..."
mkdir -p "$APP_DIR"
cd "$APP_DIR"

echo "Initializing Node.js project..."
npm init -y

echo "Installing Express.js..."
npm install express

echo "Creating index.js for node-worker..."
cat <<EOF > index.js
setInterval(() => {
  console.log(\`Node Worker: Task running at \${new Date().toISOString()}\`);
}, 5000);
EOF

echo "Creating server.js for node-server (port 3000)..."
cat <<EOF > server.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello from Node.js server on port 3000!');
});

app.listen(port, () => {
  console.log(\`Node.js server is listening on port \${port}\`);
});
EOF

echo "Changing ownership of application directory..."
sudo chown -R ec2-user:ec2-user "$APP_DIR"

echo "Starting PM2 processes..."
pm2 start index.js --name node-worker
pm2 start server.js --name node-server

echo "Saving PM2 process list and enabling startup on boot..."
pm2 save
pm2 startup systemd -u ec2-user --hp /home/ec2-user

echo "Installation and setup complete!"
