#!/bin/bash

# U11
# Check ownership and permissions of /etc/syslog.conf file
syslog_owner=$(stat -c '%U' /etc/syslog.conf)
syslog_permissions=$(stat -c '%a' /etc/syslog.conf)

# Check if U11 vulnerability exists in the output file and update it accordingly
output_file="$(dirname "$0")/OUTPUT"
grep -q "U11=true" "$output_file"
u11_exists=$?

if [ "$syslog_owner" != "root" ] || [ "$syslog_permissions" -ne 640 ]; then
    echo "Warning: /etc/syslog.conf is not owned by root or has permissions other than 640."

    if [ $u11_exists -ne 0 ]; then
        # Remove the U11 vulnerability from the output file if it was previously logged
        sed -i '/U11=/d' "$output_file"
        
        # Log the vulnerability to the output file
        echo "U11=true" >> "$output_file"
    fi
else
    if [ $u11_exists -eq 0 ]; then
        # Remove the U11 vulnerability from the output file if it was previously logged
        sed -i '/U11=/d' "$output_file"
    fi
    
    # Log that the vulnerability is not present
    echo "U11=false" >> "$output_file"
fi
