# odd-Header-Hunter
[![License](https://img.shields.io/badge/license-MIT-_red.svg)](https://opensource.org/licenses/MIT)  
<img src="https://github.com/dokDork/odd-header-hunter/raw/main/images/odd-header-hunter.png" width="250" height="250">  
  
## Description
The tool is essential for bug bounty.
Starting from a Bug Bounty Program that requires the analysis of a "Wildcard domain" (target consisting of a domain with its various subdomains) it is able to automate some phases of vulnerability research.
Given a "wildcard domain" it is in fact able to:
- **automatically extract all its subdomains** by putting together the information coming from various programs (amass, assetfinder, findomain, subfinder, shodanx, crtsh, sublist3r, ffuf). The subdomains found are however validated with httprobe.
- **for each subdomain it is able to extract all the odd headers**. To understand which are the standard headers, they are downloaded from https://www.iana.org/assignments/message-headers/message-headers.xhtml.
A strange header can be a good starting point to begin the analysis of a target host.

The final result of the processing are two files:
- output-domain-trusted.txt: contains all the subdomains found,
- output-odd-headers.txt: contains all the responses that contain strange headers.


## Example Usage
 ```
./odd-header-hunetr.sh wildcards.txt no 
 ``` 

- first parameter: wildcard.txt is a file which contains target domain to be analyzed. For example it can contain:
 ```
targetDomain.ctf
myDomanin.ctf
 ```

- second parameter: it can be yes or no and is used to exclude the amass tool from the analysis of subdomains, which can take a long time to analyze (even if I decided to set a limit of 5 minutes of analysis for each domain)


## Command-line parameters
```
./odd-header-hunter.sh <wildcard file> <activate amass>
```

| Parameter | Description                          | Example       |
|-----------|--------------------------------------|---------------|
| `wildcard file`      | file which contains target domain  | `targetDomain.ctf`, `myDomain.ctf`, ... |
| `activate amass`      | yes: activate amass analysis; no: do not activate amass analysis | `yes`, `no` |

  
## How to install it on Kali Linux (or Debian distribution)
It's very simple  
```
cd /opt
sudo git clone https://github.com/dokDork/odd-Header-Hunter.git
cd odd-Header-Hunter 
sudo chown -R "$USER":"$USER" /opt/odd-Header-Hunter
find /opt/odd-Header-Hunter -type d -exec chmod 744 {} \; 
find /opt/odd-Header-Hunter -type f -exec chmod 744 {} \; 
chmod 744 /opt/odd-Header-Hunter 
sudo chmod 755 odd-header-hunter.sh 
./odd-header-hunter.sh 
```
