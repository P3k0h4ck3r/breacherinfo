#!/bin/bash

# ==============================
#  BreacherInfo Installer
# ==============================

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN}[*] BreacherInfo Installation Started${RESET}\n"

# Required dependencies
deps=("curl" "jq" "figlet" "lolcat" "sha1sum")
missing=()

# Check dependencies
for d in "${deps[@]}"; do
  if ! command -v "$d" &>/dev/null; then
    missing+=("$d")
  fi
done

if [ ${#missing[@]} -ne 0 ]; then
  echo -e "${YELLOW}[!] Missing dependencies:${RESET} ${missing[*]}"
  echo

  if command -v apt &>/dev/null; then
    read -p "Install missing packages using apt? (y/n): " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
      sudo apt update
      sudo apt install -y "${missing[@]}"
    else
      echo -e "${RED}[-] Installation aborted${RESET}"
      exit 1
    fi

  elif command -v pacman &>/dev/null; then
    read -p "Install missing packages using pacman? (y/n): " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
      sudo pacman -Sy --needed "${missing[@]}"
    else
      echo -e "${RED}[-] Installation aborted${RESET}"
      exit 1
    fi

  else
    echo -e "${RED}[-] Unsupported package manager. Install manually.${RESET}"
    exit 1
  fi
else
  echo -e "${GREEN}[✓] All dependencies already installed${RESET}"
fi

# Make main script executable
if [ -f "breacherinfo.sh" ]; then
  chmod +x breacherinfo.sh
  echo -e "${GREEN}[✓] breacherinfo.sh is now executable${RESET}"
else
  echo -e "${RED}[-] breacherinfo.sh not found in current directory${RESET}"
fi

echo -e "\n${GREEN}[✓] Installation completed successfully${RESET}"
echo -e "${CYAN}Run the tool using:${RESET} ./breacherinfo.sh"
