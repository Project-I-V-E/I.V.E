#!/bin/bash

# U10
# Check ownership and permissions of /etc/xinetd.conf and /etc/xinetd.d/ files
xinetd_conf_owner=$(stat -c '%U' /etc/xinetd.conf)
xinetd_conf_permissions=$(stat -c '%a' /etc/xinetd.conf)

# Check if U10 vulnerability exists in the output file and update it accordingly
output_file="$(dirname "$0")/OUTPUT"
grep -q "U10=true" "$output_file"
u10_exists=$?

if [ "$xinetd_conf_owner" != "root" ] || [ "$xinetd_conf_permissions" -ne 600 ]; then
    echo "Warning: /etc/xinetd.conf is not owned by root or has permissions other than 600."

    if [ $u10_exists -ne 0 ]; then
        # Remove the U10 vulnerability from the output file if it was previously logged
        sed -i '/U10=/d' "$output_file"
        
        # Log the vulnerability to the output file
        echo "U10=true" >> "$output_file"
    fi
else
    if [ $u10_exists -eq 0 ]; then
        # Remove the U10 vulnerability from the output file if it was previously logged
        sed -i '/U10=/d' "$output_file"
    fi
    
    # Log that the vulnerability is not present
    echo "U10=false" >> "$output_file"
fi

xinetd_d_files=$(find /etc/xinetd.d/ -type f)

for file in $xinetd_d_files; do
    file_owner=$(stat -c '%U' "$file")
    file_permissions=$(stat -c '%a' "$file")

    # Check if U10 vulnerability exists in the output file and update it accordingly
    grep -q "U10=true" "$output_file"
    u10_exists=$?

    if [ "$file_owner" != "root" ] || [ "$file_permissions" -ne 600 ]; then
        echo "Warning: $file is not owned by root or has permissions other than 600."

        if [ $u10_exists -ne 0 ]; then
            # Remove the U10 vulnerability from the output file if it was previously logged
            sed -i '/U10=/d' "$output_file"
            
            # Log the vulnerability to the output file
            echo "U10=true" >> "$output_file"
        fi
    fi
done