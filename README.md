# 🔎 BreacherInfo

BreacherInfo is a Bash-based OSINT tool that checks whether an email address, phone number, or password has appeared in publicly reported data breaches or leak references.


## ✨ Features

- 📧 Email breach detection using Have I Been Pwned
- 📱 Phone number exposure discovery via OSINT references
- 🔐 Password leak checking using k-Anonymity
- 🔁 Auto re-run interactive CLI
- 🎨 Clean terminal interface (figlet + lolcat)
- 🛡️ Uses only legal, publicly available sources

## ⚙️ Requirements

- Bash (Linux / macOS)
- curl
- jq
- figlet
- lolcat
- sha1sum

## 📥 Installation

```bash
git clone https://github.com/p3k0h4ck3r/breacherinfo.git
cd breacherinfo
chmod +x install.sh breacherinfo.sh
bash install.sh

```
---

## 5️⃣ Usage

```
## 🚀 Usage

Run the tool using:

./breacherinfo.sh
```
---

## 6️⃣ How It Works (VERY IMPORTANT)

```
## 🧠 How It Works

- Email breach data is checked using the Have I Been Pwned public API.
- Passwords are checked using k-Anonymity, ensuring passwords are never sent directly.
- Phone number checks are OSINT-based and rely on public references such as indexed repositories and paste mentions.

This tool does not access private, paid, or illegal breach databases.
```
## 📄 Example Output

```
[+] Checking email breaches for: test@email.com

[!] Breaches Found:
- Adobe (Emails, Password Hashes)
- Canva (Emails, Usernames)
```

