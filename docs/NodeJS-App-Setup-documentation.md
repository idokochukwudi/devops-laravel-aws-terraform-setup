# 📦 Node.js Worker App – Setup & Test Documentation

## 🧾 Project: `node-worker-app`

This is a simple Node.js background worker application that logs a message every 5 seconds. It's designed to simulate background processing and can be used during EC2 provisioning and PM2 process management testing.

---

## 📁 Project Structure

```
node-worker-app/
│
├── index.js # Main script that logs timestamped output
├── package.json # Node.js project metadata and start script
```


---

## 📄 Files Overview

### `package.json`

```json
{
  "name": "node-worker-app",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {}
}
```

### `index.js`

```js
setInterval(() => {
  console.log(`Node Worker: Task running at ${new Date().toISOString()}`);
}, 5000);
```
#### ⚙️ Steps to Set Up and Test Locally
#### ✅ Prerequisite: Node.js Installed

Check installation:

```bash
node -v
npm -v
```

If not installed, download from https://nodejs.org.

#### 🚀 Run the Worker App
1. Navigate to your project directory:

```bash
cd ~/Documents/darey-learning/PERSONAL_PROJECTS/node-worker-app
```
2. Install dependencies (if any are added later):

```bash
npm install
```
3. Start the worker:

```bash
npm start
```

#### ✅ Expected Output

```bash
> node-worker-app@1.0.0 start
> node index.js

...
Node Worker: Task running at 2025-07-28T20:12:26.961Z
Node Worker: Task running at 2025-07-28T20:12:31.968Z
Node Worker: Task running at 2025-07-28T20:12:36.968Z
```

#### 🌀 Optional: Run App in Background using PM2
PM2 allows the app to run persistently like it would on an EC2 instance.

1. Install PM2 globally:

```bash
npm install -g pm2
```
2. Start the app:

```bash
pm2 start index.js --name node-worker
```

3. View logs:

```bash
pm2 logs node-worker
```

4. Stop the app:

```bash
pm2 stop node-worker
```

| Component     | Status      |
| ------------- | ----------- |
| Node App Init | ✅ Complete |
| Files Created | ✅ Complete |
| Local Test    | ✅ Passed   |
| PM2 Ready     | ⚙️ Optional |
