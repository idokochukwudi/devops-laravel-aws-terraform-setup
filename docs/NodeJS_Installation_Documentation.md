
## Node.js Installation on Amazon Linux 2023 Using `install_nodejs.sh`

### Objective

Automate the installation and configuration of **Node.js**, **npm**, **Yarn**, and **PM2** on an Amazon EC2 instance running **Amazon Linux 2023**, using a shell script named `install_nodejs.sh`.

---

### Script: `install_nodejs.sh`

```bash
#!/bin/bash

# Enable logging
exec > /var/log/install_nodejs.log 2>&1
set -e

# Update system packages
sudo dnf update -y

# Install Node.js 20
curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo dnf install -y nodejs

# Confirm Node.js and npm installation
node -v
npm -v

# Install yarn
sudo npm install -g yarn

# Install pm2
sudo npm install -g pm2

# Start PM2 and run a sample app (adjust as needed)
pm2 start ~/node-worker/index.js
pm2 save
pm2 startup
```

---

### Issues Encountered

#### 1. Script Failed via User Data

- **Issue**: The script didn't execute when attached to EC2 instance via User Data.
- **Diagnostics**:
  - Checked log: `/var/log/cloud-init-output.log`
  - Verified `#!/bin/bash` and permissions.
- **Attempts**:
  - Added `set -e`, logging.
  - Tried different approaches to fix permissions.
- **Conclusion**: All automated attempts failed.
- **Action Taken**: Proceeded with **manual SSH-based execution**.

---

#### 2. Curl Conflict During Installation

- **Error Output**:
  ```
  package curl-minimal conflicts with curl
  try to add '--allowerasing' to command line to replace conflicting packages
  ```

- **Resolution**:
  Manually ran:
  ```bash
  sudo dnf install -y nodejs --allowerasing
  ```

---

### Manual Installation Steps

After connecting to the EC2 instance via SSH:

1. **Uploaded Script**:
   ```bash
   chmod +x install_nodejs.sh
   ./install_nodejs.sh
   ```

2. **Verified Installations**:
   ```bash
   node -v 
   npm -v
   yarn -v
   pm2 -v
   ```

3. **Started Node App via PM2**:
   ```bash
   pm2 start ~/node-worker/index.js
   pm2 save
   pm2 startup
   ```

---

### PM2 Output Snapshot

```
[PM2] Starting /home/ec2-user/node-worker/index.js in fork_mode (1 instance)
[PM2] Done.

┌────┬───────────────┬────────┬─────┬─────────┬─────┬────────┐
│ id │ name          │ mode   │ ↺   │ status  │ cpu │ memory │
├────┼───────────────┼────────┼─────┼─────────┼─────┼────────┤
│ 0  │ node-worker   │ fork   │ 0   │ online  │ 0%  │ 31.8mb │
└────┴───────────────┴────────┴─────┴─────────┴─────┴────────┘
```

---

### Summary Table

| Step                          | Status        |
|-------------------------------|---------------|
| EC2 User Data Execution       | ❌ Failed      |
| Manual Script Execution       | ✅ Successful  |
| Curl Package Conflict         | ✅ Resolved    |
| Node.js & Tools Installation  | ✅ Completed   |
| PM2 App Running               | ✅ Verified    |

---

### Useful References

- [NodeSource Distributions](https://github.com/nodesource/distributions)
- [PM2 Documentation](https://pm2.keymetrics.io/)
- [Amazon Linux 2023 Docs](https://docs.aws.amazon.com/linux/al2023/ug/what-is-amazon-linux.html)
