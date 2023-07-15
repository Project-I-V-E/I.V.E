#!/bin/bash

# U12
# Check ownership and permissions of /etc/services file
services_owner=$(stat -c '%U' /etc/services)
services_permissions=$(stat -c '%a' /etc/services)

# Check if U12 vulnerability exists in the output file and update it accordingly
output_file="$(dirname "$0")/OUTPUT"
grep -q "U12=true" "$output_file"
u12_exists=$?

if [ "$services_owner" != "root" ] || [ "$services_permissions" -ne 644 ]; then
    echo "Warning: /etc/services is not owned by root or has permissions other than 644."

    if [ $u12_exists -ne 0 ]; then
        # Remove the U12 vulnerability from the output file if it was previously logged
        sed -i '/U12=/d' "$output_file"
        
        # Log the vulnerability to the output file
        echo "U12=true" >> "$output_file"
    fi
else
    if [ $u12_exists -eq 0 ]; then
        # Remove the U12 vulnerability from the output file if it was previously logged
        sed -i '/U12=/d' "$output_file"
    fi
    
    # Log that the vulnerability is not present
    echo "U12=false" >> "$output_file"
fi

# ... Add more vulnerability checks here ...

# Final step: Print a summary
if [ -f "$output_file" ]; then
    echo "Vulnerability analysis completed. Check the output file: $output_file"
else
    echo "No vulnerabilities found."
fi