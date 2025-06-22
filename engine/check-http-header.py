import os
import requests
from bs4 import BeautifulSoup

IANA_URL = "https://www.iana.org/assignments/http-fields/http-fields.xhtml"
OUTPUT_FILE = "output-odd-headers.txt"

# Local fallback list of standard HTTP headers (partial, extend as needed)
LOCAL_STANDARD_HEADERS = [
    "Accept",
    "Accept-Charset",
    "Accept-Encoding",
    "Accept-Language",
    "Authorization",
    "Cache-Control",
    "Connection",
    "Content-Length",
    "Content-Type",
    "Cookie",
    "Date",
    "Expect",
    "From",
    "Host",
    "If-Match",
    "If-Modified-Since",
    "If-None-Match",
    "If-Range",
    "If-Unmodified-Since",
    "Max-Forwards",
    "Pragma",
    "Proxy-Authorization",
    "Range",
    "Referer",
    "TE",
    "Trailer",
    "Transfer-Encoding",
    "Upgrade",
    "User-Agent",
    "Via",
    "Warning",
    "Set-Cookie",
    # Add more as needed
]

def download_standard_headers():
    """
    Download the list of standard HTTP headers from IANA and parse them.
    Returns a list of header strings in lowercase.
    Falls back to LOCAL_STANDARD_HEADERS on failure.
    """
    try:
        print("Downloading standard HTTP headers from IANA...")
        resp = requests.get(IANA_URL, timeout=10)
        resp.raise_for_status()
        soup = BeautifulSoup(resp.text, "html.parser")

        # The headers are listed in a table with id 'table-http-fields'
        table = soup.find("table", id="table-http-fields")
        if not table:
            # fallback: try first table on page
            table = soup.find("table")
        if not table:
            raise ValueError("Could not find headers table in IANA page")

        headers = set()
        rows = table.find_all("tr")
        for row in rows[1:]:  # skip header row
            cols = row.find_all("td")
            if not cols:
                continue
            header_name = cols[0].get_text(strip=True)
            if header_name:
                headers.add(header_name.lower())

        if not headers:
            raise ValueError("No headers parsed from IANA page")

        print(f"Downloaded {len(headers)} standard headers.")
        return list(headers)

    except Exception as e:
        print(f"Failed to download or parse IANA headers: {e}")
        print("Using local fallback header list.")
        return [h.lower() for h in LOCAL_STANDARD_HEADERS]

def is_header_standard(line, standard_headers):
    """
    Checks if the line contains any standard header substring (case-insensitive).
    Returns True if standard, False otherwise.

    Lines containing "HTTP/", "GET ", or "POST " are not considered headers and always return True.
    """
    line_lower = line.lower()

    # Skip lines that are not headers
    if any(x in line_lower for x in ("http/", "get ", "post ")):
        return True

    for std_header in standard_headers:
        if std_header in line_lower:
            return True
    return False

def scan_headers_files(standard_headers):
    """
    Recursively scans all .headers files in subdirectories,
    writes output to OUTPUT_FILE with non-standard headers highlighted.
    """
    with open(OUTPUT_FILE, "w", encoding="utf-8") as outf:
        for root, _, files in os.walk("."):
            for filename in files:
                if filename.endswith(".headers"):
                    filepath = os.path.join(root, filename)
                    try:
                        with open(filepath, "r", encoding="utf-8", errors="ignore") as f:
                            lines = f.readlines()
                    except Exception as e:
                        print(f"Warning: Could not read file {filepath}: {e}")
                        continue

                    non_standard_found = False
                    marked_lines = []
                    for line in lines:
                        stripped = line.strip()
                        if stripped == "":
                            marked_lines.append(line)
                            continue

                        if is_header_standard(stripped, standard_headers):
                            marked_lines.append(line)
                        else:
                            marked_lines.append(">>> " + line)
                            non_standard_found = True

                    if non_standard_found:
                        outf.write("\n")
                        outf.write("\n")                        
                        outf.write(f"--- File: {filepath} ---\n")
                        outf.writelines(marked_lines)
                        outf.write("\n")

def main():
    standard_headers = download_standard_headers()
    scan_headers_files(standard_headers)
    print(f"Scan completed. Results saved in '{OUTPUT_FILE}'.")

if __name__ == "__main__":
    main()
