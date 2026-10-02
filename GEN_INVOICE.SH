#!/bin/sh
# =========================================================
# Script: gen_invoice.sh
# Purpose: Fill details into an HTML invoice file from a template
# Author: R.Manietta
# Date: 
# Version:
# =========================================================

# Exit on error
set -e

# ----------- CONFIGURATION -----------
OUTPUT_FILE="cash_$(date +"%d-%m-%Y)Invoice.html"
TEMPLATE_FILE="invoice.html"

# ----------- SAMPLE DATA -------------
CustNAME=Cash
CURRENT_DATE=$(date +"%Y-%m-%d")
UPTIME_INFO=$(uptime -p)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5 " used of " $2}')
MEMORY_USAGE=$(free -h | awk '/Mem:/ {print $3 " used of " $2}')

# ----------- CHECK TEMPLATE ----------
if [[ ! -f "$TEMPLATE_FILE" ]]; then
    echo "Error: Template file '$TEMPLATE_FILE' not found."
    exit 1
fi

# ----------- GENERATE HTML -----------
# Replace placeholders in template with actual values
sed \
    -e "s/{{CustNAME}}/$CustNAME/g" \
    -e "s/{{DATE}}/$CURRENT_DATE/g" \
    -e "s/{{UPTIME}}/$UPTIME_INFO/g" \
    -e "s/{{DISK}}/$DISK_USAGE/g" \
    -e "s/{{MEMORY}}/$MEMORY_USAGE/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

echo "✅ HTML report generated: $OUTPUT_FILE"
