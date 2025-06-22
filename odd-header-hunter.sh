#!/bin/bash

show_version(){
echo ""
echo ""
echo '  /$$$$$$        /$$       /$$       /$$   /$$                           /$$                    '
echo ' /$$__  $$      | $$      | $$      | $$  | $$                          | $$                    '
echo '| $$  \ $$  /$$$$$$$  /$$$$$$$      | $$  | $$  /$$$$$$   /$$$$$$   /$$$$$$$  /$$$$$$   /$$$$$$ '
echo '| $$  | $$ /$$__  $$ /$$__  $$      | $$$$$$$$ /$$__  $$ |____  $$ /$$__  $$ /$$__  $$ /$$__  $$'
echo '| $$  | $$| $$  | $$| $$  | $$      | $$__  $$| $$$$$$$$  /$$$$$$$| $$  | $$| $$$$$$$$| $$  \__/'
echo '| $$  | $$| $$  | $$| $$  | $$      | $$  | $$| $$_____/ /$$__  $$| $$  | $$| $$_____/| $$      '
echo '|  $$$$$$/|  $$$$$$$|  $$$$$$$      | $$  | $$|  $$$$$$$|  $$$$$$$|  $$$$$$$|  $$$$$$$| $$      '
echo ' \______/  \_______/ \_______/      |__/  |__/ \_______/ \_______/ \_______/ \_______/|__/      '
echo ""                                                                                                
echo ""                                                                                                
echo ""                                                                                                
echo ' /$$   /$$                       /$$                                                            '
echo '| $$  | $$                      | $$                                                            '
echo '| $$  | $$ /$$   /$$ /$$$$$$$  /$$$$$$    /$$$$$$   /$$$$$$                                     '
echo '| $$$$$$$$| $$  | $$| $$__  $$|_  $$_/   /$$__  $$ /$$__  $$                                    '
echo '| $$__  $$| $$  | $$| $$  \ $$  | $$    | $$$$$$$$| $$  \__/                                    '
echo '| $$  | $$| $$  | $$| $$  | $$  | $$ /$$| $$_____/| $$                                          '
echo '| $$  | $$|  $$$$$$/| $$  | $$  |  $$$$/|  $$$$$$$| $$                                          '
echo '|__/  |__/ \______/ |__/  |__/   \___/   \_______/|__/                                          '
echo ""
echo " version 1.0"
sleep 1
}


# Function to check if a program is installed
is_installed() {
    local program="$1"
    if command -v "$program" &> /dev/null; then
	return 0 # Installato
    else
	return 1 # Non installato
    fi
}

function usage() {
  cat << EOF
Usage: $0 <domains_file> <use_amass>

Parameters:
  domains_file   File containing list of domains to test (one per line)
  use_amass      yes  -> run amass scan (may be slow)
                 no   -> skip amass scan

Example:
  $0 targets.txt yes
  $0 targets.txt no
EOF
}

# Check if two arguments are passed
if [ $# -ne 2 ]; then
  echo "Error: Missing parameters."
  usage
  exit 1
fi

domains_file="$1"
use_amass="$2"

# Check if domains_file exists
if [ ! -f "$domains_file" ]; then
  echo "Error: File '$domains_file' not found."
  exit 1
fi

# Validate use_amass parameter
if [[ "$use_amass" != "yes" && "$use_amass" != "no" ]]; then
  echo "Error: Second parameter must be 'yes' or 'no'."
  usage
  exit 1
fi

# Verify installed program
echo ""
echo "[i] verify installed program"

# seclists
echo ""
program="seclists"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	# Comando di installazione del programma
	# Esempio: sudo apt-get install -y "$program"
	cd /usr/share
	sudo apt-get install -y $program
else
	echo "[i] $program is already installed."
fi

# amass
echo ""
program="amass"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	# Comando di installazione del programma
	# Esempio: sudo apt-get install -y "$program"
	cd /usr/share
	sudo apt-get install -y $program
else
	echo "[i] $program is already installed."
fi

# assetfinder
echo ""
program="assetfinder"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	# Comando di installazione del programma
	# Esempio: sudo apt-get install -y "$program"
	go install github.com/tomnomnom/assetfinder@latest
	sudo cp /home/kali/go/bin/assetfinder /usr/bin
else
	echo "[i] $program is already installed."
fi

# findomain
echo ""
program="findomain"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	# Comando di installazione del programma
	# Esempio: sudo apt-get install -y "$program"
	go install github.com/Edu4rdSHL/findomain/v2@latest
	sudo cp /home/kali/go/bin/findomain /usr/bin
else
	echo "[i] $program is already installed."
fi

# subfinder
echo ""
program="subfinder"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	# Comando di installazione del programma
	# Esempio: sudo apt-get install -y "$program"
	cd /usr/share
	sudo apt install -y $program
else
	echo "[i] $program is already installed."
fi

# shodanx
echo ""
program="shodanx"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	# Comando di installazione del programma
	# Esempio: sudo apt-get install -y "$program"
	pip install git+https://github.com/RevoltSecurities/ShodanX --break-system-packages  
else
	echo "[i] $program is already installed."
fi

# crtsh
echo ""
program="crtsh"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."	
	sudo touch /usr/bin/crtsh
	sudo chmod 777 /usr/bin/crtsh
	sudo echo 'curl -s https://crt.sh/\?cn\=%.$1\&output=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u' > /usr/bin/crtsh
	sudo chmod 755 /usr/bin/crtsh
else
	echo "[i] $program is already installed."
fi

# sublist3r
echo ""
program="sublist3r"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	# Comando di installazione del programma
	# Esempio: sudo apt-get install -y "$program"
	cd /usr/share
	sudo apt-get install -y $program
else
	echo "[i] $program is already installed."
fi

# ffuf
echo ""
program="ffuf"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	# Comando di installazione del programma
	# Esempio: sudo apt-get install -y "$program"
	cd /usr/share
	sudo apt-get install -y $program
else
	echo "[i] $program is already installed."
fi

# httprobe
echo ""
program="httprobe"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	# Comando di installazione del programma
	# Esempio: sudo apt-get install -y "$program"
	cd /usr/share
	sudo apt-get install -y $program
else
	echo "[i] $program is already installed."
fi


# fff
echo ""
program="fff"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	go install github.com/tomnomnom/fff@latest
	sudo cp /home/kali/go/bin/fff /usr/bin
else
	echo "[i] $program is already installed."
fi

# anew
echo ""
program="anew"
printf "\n===================================\n"
if ! is_installed "$program"; then
	echo "[->] Installing $program..."
	sudo wget https://github.com/tomnomnom/anew/releases/download/v0.1.1/anew-linux-386-0.1.1.tgz
	sudo tar -xvf  anew-linux-386-0.1.1.tgz  
	sudo mv anew /usr/local/bin/anew
else
	echo "[i] $program is already installed."
fi

show_version

# Ricava la cartella in cui si trova lo script (bash)
myPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Crea la cartella appo dentro myPath senza errori se esiste già
mkdir -p "$myPath/appo"

### amass
echo ""
if [ "$use_amass" == "yes" ]; then
  while read -r domain; do
    echo "[i] Running amass on domain: $domain"
    echo "[i] Executing command:"
	echo "[i] amass enum --passive -d "$domain" -norecursive -timeout 5 -o \"$myPath/appo/amass-appo.txt\""
	amass enum --passive -d "$domain" -norecursive -timeout 5 -o "$myPath/appo/amass-appo.txt"
  done < "$domains_file"
  # pulisco l'output di amass
  mv "$myPath/appo/amass-appo.txt" "$myPath/appo/amass-appo.tmp"
  cat "$myPath/appo/amass-appo.tmp" | sed 's/\x1b\[[0-9;]*m//g' | grep -oE '[a-zA-Z0-9.-]+\.linkedin\.com' | sort -u > "$myPath/appo/amass-appo.txt"
  cat "$myPath/appo/amass-appo.txt" | anew "$myPath/appo/domains-not-trusted.txt"
  rm "$myPath/appo/amass-appo.txt"
  rm "$myPath/appo/amass-appo.tmp"
else
  echo "[i] Skipping amass scan (yeah it's too long!)"
fi


### assetfinder
echo ""
echo "[i] Running assetfinder on all domains defined in $domains_file"
echo "[i] Executing command:"
echo "[i] cat \"$domains_file\" | assetfinder --subs-only | anew \"$myPath/appo/domains-not-trusted.txt\""
cat "$domains_file" | assetfinder --subs-only | anew "$myPath/appo/domains-not-trusted.txt"


### findomanin
echo ""
echo "[i] Running findomain on all domains defined in $domains_file"
echo "[i] Executing command:"
echo "[i] findomain -f \"$domains_file\" | anew \"$myPath/appo/domains-not-trusted.txt\""
findomain -f "$domains_file" | anew "$myPath/appo/domains-not-trusted.txt"
### pulisco l'output di findomain
grep -v -E '^(Target|Search|Job finished|Good luck|Rate limit)|^$|A error has occurred' "$myPath/appo/domains-not-trusted.txt" > "$myPath/appo/domains.tmp" && mv "$myPath/appo/domains.tmp" "$myPath/appo/domains-not-trusted.txt" 


### subfinder
echo ""
echo "[i] Running subfinder"
while read -r domain; do
  echo "[i] Running subfinder on domain: $domain"
  echo "[i] subfinder -d "$domain" -o \"$myPath/appo/subfinder-appo.txt\""
  subfinder -d "$domain" -o "$myPath/appo/subfinder-appo.txt" 
done < "$domains_file"
cat "$myPath/appo/subfinder-appo.txt" | anew "$myPath/appo/domains-not-trusted.txt"
rm "$myPath/appo/subfinder-appo.txt"


### shodanx
echo ""
echo "[i] Running shodanx"
while read -r domain; do
  echo "[i] Running shodanx on domain: $domain"
  echo "[i] shodanx subdomain -d \"$domain\" -o \"$myPath/appo/shodan-appo.txt\""
  shodanx subdomain -d "$domain" -o "$myPath/appo/shodan-appo.txt" 
done < "$domains_file"
cat "$myPath/appo/shodan-appo.txt" | anew "$myPath/appo/domains-not-trusted.txt"
rm "$myPath/appo/shodan-appo.txt"


### crt.sh
echo ""
echo "[i] Running crt.sh"
while read -r domain; do
  echo "[i] Running crt.sh on domain: $domain"
  echo "[i] crtsh \"$domain\" >> \"$myPath/appo/crt-appo.txt\""
  crtsh "$domain" >> "$myPath/appo/crt-appo.txt"
done < "$domains_file"
cat "$myPath/appo/crt-appo.txt" | anew "$myPath/appo/domains-not-trusted.txt"
rm crt-appo.txt


### sublist3r.sh
echo ""
echo "[i] Running sublist3r.sh"
while read -r domain; do
  echo "[i] Running sublist3r.sh on domain: $domain"
  echo "[i] sublist3r -d \"$domain\" -o \"$myPath/appo/sublist3r-appo.txt\""
  sublist3r -d "$domain" -o "$myPath/appo/sublist3r-appo.txt"
done < "$domains_file"
cat "$myPath/appo/sublist3r-appo.txt" | anew "$myPath/appo/domains-not-trusted.txt"
rm "$myPath/appo/sublist3r-appo.txt"


### ffuf
echo ""
echo "[i] Running ffuf"
while read -r domain; do
  ip=$(dig "$domain" @8.8.8.8 +short | head -n1)
  echo "[i] Running ffuf on domain: $domain"
  echo "[i] ffuf -H \"Host: FUZZ.\"$domain -u http://$ip -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt -mc 200 -o \"$myPath/appo/ffuf-appo.txt\" -of md\""
  ffuf -H "Host: FUZZ."$domain -u http://$ip -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt -mc 200 -o "$myPath/appo/ffuf-appo.txt" -of md
done < "$domains_file"
awk -F, 'NR>1 {gsub(/\.$/, "", $2); print $2 ~ /^https/ ? "https://" $1 "." substr($2,9) : $1 "." substr($2,8)}' "$myPath/appo/ffuf-appo.txt" > "$myPath/appo/ffuf-appo-clean.txt"
cat "$myPath/appo/ffuf-appo-clean.txt" | anew "$myPath/appo/domains-not-trusted.txt"
rm "$myPath/appo/ffuf-appo-clean.txt"


### verifico quali siti sono attivi
echo ""
echo "[i] Check which hosts are actually active"
cat "$myPath/appo/domains-not-trusted.txt" | httprobe -c 50 | anew "$myPath/output-domain-trusted.txt"

### Cancello la cartella di appoggio
rm -r "$myPath/appo/"

### scarico la root dei siti attivi
echo ""
echo "[i] I Download the root page of the active sites"
cat "$myPath/output-domain-trusted.txt" | fff -d 1 -S -o "$myPath/roots"

echo ""
echo "[i] Analyze the headers of the downloaded root pages looking for odd HTTP headers"
### analizzo gli header non standard
python3 "$myPath/engine/check-http-header.py" "$myPath/roots"
mv "$myPath/engine/output-odd-headers.txt" "$myPath/output-odd-headers.txt"

echo ""
echo "analysis completed"
echo "See you next game..."
