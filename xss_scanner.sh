#!/bin/bash

# Define target domain
domain="$1"

# Step 1: Find subdomains
subfinder -d "$domain" -o subdomains.txt

# Step 2: Check live subdomains
httpx-toolkit -l subdomains.txt -o live_subdomains.txt

# Step 3: Find endpoints
echo "$domain" | gau --threads 5 >> endpoints.txt
cat live_subdomains.txt | katana -jc >> endpoints.txt

# Step 4: Remove duplicate endpoints
cat endpoints.txt | uro > unique_endpoints.txt

# Step 5: Filter endpoints for potential XSS vectors
cat unique_endpoints.txt | gf xss > xss_endpoints.txt

# Step 6: Find reflected parameters
cat xss_endpoints.txt | Gxss -p kxXSS -o reflected_params.txt

# Step 7: Check for XSS vulnerabilities
dalfox file reflected_params.txt -o vulnerable_xss.txt

# Output results
echo "XSS Scan Completed. Check vulnerable_xss.txt for results."
