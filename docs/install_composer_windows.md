
# ✅ Installing Composer on Windows (for Laravel Projects)

## 🖥️ System Info
- **OS:** Windows 10/11
- **Shells Used:** PowerShell and Git Bash
- **Objective:** Install Composer globally and make it usable in Git Bash for Laravel project setup

---

## 🔧 Step 1: Install PHP Manually (if not already installed)

Laravel (and Composer) requires PHP. If PHP was not already installed:

1. Go to the official PHP Windows download page:  
   🔗 https://windows.php.net/download/
2. Download the latest **non-thread-safe x64 .zip** file (e.g., `php-8.4.x-nts-Win32-vs16-x64.zip`).
3. Extract it to a directory, e.g., `C:\php`.
4. Rename `php.ini-development` to `php.ini`.
5. Enable required extensions in `php.ini` (use Notepad++ or VS Code):
   ```ini
   extension=fileinfo
   extension=mbstring
   extension=openssl
   extension=pdo_mysql
   ```
6. Add PHP to system PATH:
   - Open *System Properties > Environment Variables*.
   - Under **System variables**, find and edit `Path`.
   - Add: `C:\php`

---

## ✅ Step 2: Install Composer for Windows

1. Visit:  
   🔗 https://getcomposer.org/download/
2. Download and run the **Composer-Setup.exe**.
3. During setup:
   - Select the path to your `php.exe` (e.g., `C:\php\php.exe`).
   - Allow Composer to add itself to the system PATH.

4. Finish the setup.

---

## 🧪 Step 3: Verify Composer in PowerShell

Open **PowerShell** and run:

```powershell
composer --version
```

Expected output:

```
Composer version 2.8.x ...
```

---

## ⚠️ Step 4: Make Composer Work in Git Bash

By default, Git Bash might not recognize Composer.

1. Run this in **PowerShell** to find the Composer location:

```powershell
Get-Command composer
```

You’ll see something like:

```
C:\ProgramData\ComposerSetup\bin\composer.bat
```

2. Open **Git Bash** and run the following:

```bash
echo 'export PATH=$PATH:/c/ProgramData/ComposerSetup/bin' >> ~/.bashrc
source ~/.bashrc
```

3. Then test in Git Bash:

```bash
composer --version
```

Expected output:

```
Composer version 2.8.x ...
```

---

## 🏁 Conclusion

You’ve now successfully:

- Installed PHP manually
- Installed Composer globally
- Made Composer accessible from both PowerShell and Git Bash
- Verified it works by running `composer --version`

You’re now ready to create Laravel apps using Composer in your terminal of choice.
