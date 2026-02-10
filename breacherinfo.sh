#!/bin/bash

# ==============================
#  BreacherInfo - OSINT Tool
#  Author: Peko
# ==============================

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

# Check dependencies
deps=("curl" "jq" "figlet" "lolcat" "sha1sum")
for d in "${deps[@]}"; do
  command -v $d &>/dev/null || {
    echo -e "${RED}[-] Missing dependency: $d${RESET}"
    exit 1
  }
done

# ==============================
# Functions
# ==============================

banner() {
  clear
  figlet breacherinfo | lolcat
  echo -e "${CYAN}OSINT Breach & Leak Information Tool${RESET}"
  echo -e "${YELLOW}Email & Phone Exposure Checker (Public Sources Only)${RESET}"
  echo -e "${CYAN}GitHub:p3k0h4ck3r \t Instagram:@pekopekoboy5${RESET}\n"
}

check_email_breach() {
  local email="$1"
  echo -e "\n${GREEN}[+] Checking email breaches for: $email${RESET}"

  response=$(curl -s \
    -H "User-Agent: breacherinfo" \
    "https://haveibeenpwned.com/api/v3/breachedaccount/$email")

  if echo "$response" | jq empty 2>/dev/null; then
    echo -e "${RED}[!] Breaches Found:${RESET}"
    echo "$response" | jq -r '.[] | "- \(.Name) (\(.DataClasses | join(", ")))"'
  else
    echo -e "${GREEN}[✓] No public breach found for this email${RESET}"
  fi
}

check_password_pwned() {
  local password="$1"
  sha1=$(echo -n "$password" | sha1sum | awk '{print toupper($1)}')
  prefix=${sha1:0:5}
  suffix=${sha1:5}

  echo -e "\n${GREEN}[+] Checking password exposure (k-anonymity)...${RESET}"

  result=$(curl -s "https://api.pwnedpasswords.com/range/$prefix")

  if echo "$result" | grep -q "$suffix"; then
    count=$(echo "$result" | grep "$suffix" | cut -d':' -f2)
    echo -e "${RED}[!] Password FOUND in breaches ($count times)${RESET}"
  else
    echo -e "${GREEN}[✓] Password not found in known breaches${RESET}"
  fi
}

check_phone_osint() {
  local phone="$1"
  echo -e "\n${GREEN}[+] Checking phone number exposure: $phone${RESET}"

  echo -e "${YELLOW}[*] OSINT-based search (references only)${RESET}"
  echo -e "- GitHub search:"
  echo "  https://github.com/search?q=$phone&type=code"

  echo -e "- Google indexed leaks:"
  echo "  https://www.google.com/search?q=\"$phone\"+\"database\"+\"leak\""

  echo -e "${CYAN}[i] Manual verification required${RESET}"
  echo -e "${CYAN}[i] Confidence: Medium${RESET}"
}

# ==============================
# MAIN LOOP
# ==============================

while true; do
  banner

  echo "Choose an option:"
  echo "1) Check Email Breach"
  echo "2) Check Phone Number Exposure"
  echo "3) Check Password Leak"
  echo "4) Exit"
  read -p ">> " choice

  case $choice in
    1)
      read -p "Enter email address: " email
      check_email_breach "$email"
      ;;
    2)
      read -p "Enter phone number (with country code): " phone
      check_phone_osint "$phone"
      ;;
    3)
      read -s -p "Enter password (hidden): " password
      echo
      check_password_pwned "$password"
      ;;
    4)
      echo -e "\n${CYAN}Bye hacker 👋${RESET}"
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid option${RESET}"
      ;;
  esac

  echo -e "\n${YELLOW}Press Enter to continue...${RESET}"
  read
done
