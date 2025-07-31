# 📘 Phase 2 – Laravel App Setup (Comprehensive Documentation)

## ✅ Objective

Set up a minimal, production-ready Laravel application integrated with an RDS MySQL database backend, ready for EC2 deployment and ALB integration.

---

## 📁 Project Structure

```
/laravel-starter-app
│
├── .env # Laravel environment file (local/dev)
├── .env.laravel-node # Environment file for RDS integration
├── composer.json
├── composer.lock
├── README.md
├── /app
├── /config
├── /database
├── /resources
└── /routes
```


---

## 🔧 Prerequisites

- Git and GitHub
- PHP >= 8.1
- Composer
- Node.js & NPM (optional for frontend build)
- Laravel CLI
- VS Code or another IDE

---

## 🔨 Steps Taken

### 🔹 1. Created GitHub Repository

- Repository Name: `laravel-starter-app`
- Cloned locally via:

```bash
git clone https://github.com/YOUR_USERNAME/laravel-starter-app.git
cd laravel-starter-app
```

🔹 2. Installed Laravel via Composer
```
composer create-project laravel/laravel .
```

🔹 3. Installed Livewire
```
composer require livewire/livewire
```

🔹 4. Generated Laravel App Key
```
php artisan key:generate
```

🔹 5. Prepared Environment Configuration
Created a custom environment file for cloud usage:

```
# .env.laravel-node

APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=rds-endpoint.amazonaws.com
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=laravel_user
DB_PASSWORD=securepassword

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_CONNECTION=sync
```

🔹 6. Git Tracking

Ensured .gitignore includes sensitive files such as .env.

⏳ Next Steps (Post RDS Provisioning)

1. Replace DB_HOST in .env.laravel-node with actual RDS endpoint.
2. Copy config to .env:

```
cp .env.laravel-node .env
```
3. Run database migrations:

```
php artisan migrate
```

### Deployment Notes
- This app will be deployed to an EC2 instance managed by an Auto Scaling Group.
- An Application Load Balancer (ALB) will route traffic.
- Environment variables will be passed using a userdata script or SSM Parameter Store.

## 🔁 Useful Commands

| Task                      | Command                  |
|---------------------------|---------------------------|
| Serve App Locally         | `php artisan serve`       |
| Install Composer Packages | `composer install`        |
| Generate App Key          | `php artisan key:generate`|
| Run Migrations            | `php artisan migrate`     |

---

## ✅ Status

| Component         | Status         |
|-------------------|----------------|
| Laravel Installed | ✅ Complete     |
| Livewire Added    | ✅ Complete     |
| Env Config Ready  | ✅ Done         |
| Database Ready    | ⏳ Pending RDS  |
