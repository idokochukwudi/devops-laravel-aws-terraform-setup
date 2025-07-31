#!/bin/bash

# Enable logging to home directory and print commands as they run
exec > ~/install_laravel.log 2>&1
set -ex

echo "Starting Laravel installation on Amazon Linux 2023..."

# Step 1: Update system
echo "Updating system packages..."
sudo dnf update -y

# Step 2: Install PHP, Nginx, MariaDB connector, and other required packages with --allowerasing to fix conflicts
echo "Installing required packages..."
sudo dnf install -y --allowerasing nginx php php-cli php-fpm php-mbstring php-xml php-bcmath php-curl php-mysqlnd unzip git wget mariadb-connector-c

# Step 3: Enable and start services
echo "Enabling and starting php-fpm and nginx services..."
sudo systemctl enable php-fpm nginx
sudo systemctl start php-fpm nginx
sleep 5  # Wait for services to stabilize

# Step 4: Install Composer globally
echo "Installing Composer globally..."
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer --version

# Step 5: Clone Laravel Project (remove existing folder if any)
echo "Preparing Laravel app directory and cloning repository..."
sudo mkdir -p /var/www
sudo rm -rf /var/www/laravel-app
cd /var/www
sudo git clone https://github.com/idokochukwudi/laravel-starter-app.git laravel-app

# Step 6: Set Permissions (use 'apache' user on Amazon Linux)
echo "Setting ownership and permissions for Laravel app..."
cd laravel-app
sudo chown -R apache:apache /var/www/laravel-app
sudo chmod -R 775 storage bootstrap/cache

# Step 7: Install Laravel dependencies
echo "Installing Laravel dependencies with composer..."
sudo -u apache composer install --no-interaction --prefer-dist --optimize-autoloader

# Step 8: Setup .env and generate app key with proper permissions
echo "Setting up .env file and generating application key..."
sudo cp .env.laravel-node .env
sudo chown apache:apache /var/www/laravel-app/.env
sudo chmod 664 /var/www/laravel-app/.env
cd /var/www/laravel-app
sudo -u apache php artisan key:generate

# Step 9: Configure nginx for Laravel
echo "Writing nginx configuration for Laravel..."
sudo tee /etc/nginx/conf.d/laravel.conf > /dev/null <<EOF
server {
    listen 80;
    server_name _;

    root /var/www/laravel-app/public;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        include /etc/nginx/fastcgi_params;
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

# Step 10: Restart nginx and php-fpm
echo "Restarting nginx and php-fpm..."
sudo systemctl restart php-fpm
sudo systemctl restart nginx
sleep 5  # Give services time to restart properly

echo "Laravel installation completed successfully!"
