# odd-Header-Hunter
[![License](https://img.shields.io/badge/license-MIT-_red.svg)](https://opensource.org/licenses/MIT)  
<img src="https://github.com/dokDork/red-team-penetration-test-script/raw/main/images/siteSniper.png" width="250" height="250">  
  
## Description
The tool is essential for bug bounty.
Starting from a Bug Bounty Program that requires the analysis of a "Wildcard domain" (target consisting of a domain with its various subdomains) it is able to automate some phases of vulnerability research.
Given a "wildcard domain" it is in fact able to:
- automatically extract all its subdomains by putting together the information coming from various programs (amass, assetfinder, findomain, subfinder, shodanx, crtsh, sublist3r, ffuf). The subdomains found are however validated with httprobe.
- for each subdomain it is able to extract all the strange headers. To understand which are the standard headers, they are downloaded from https://www.iana.org/assignments/message-headers/message-headers.xhtml.
A strange header can be a good starting point to begin the analysis of a target host.

The final result of the processing are two files:
- output-domain-trusted.txt: contains all the subdomains found,
- output-odd-headers.txt: contains all the responses that contain strange headers.
