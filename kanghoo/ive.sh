#!/bin/bash

# U9
# Check ownership and permissions of /etc/hosts file
file_owner=$(stat -c '%U' /etc/hosts)
file_permissions=$(stat -c '%a' /etc/hosts)

# If the owner of the file is not root or the permissions are greater than 600, echo a warning
if [ "$file_owner" != "root" ] || [ "$file_permissions" -gt 600 ]; then
    echo "Warning: /etc/hosts file is not owned by root or has permissions above 600."

    # Log the vulnerability to the output file
    output_file="$(dirname "$0")/OUTPUT"
    echo "U9=true" > "$output_file"
else
    # Remove the U9 vulnerability from the output file if it was previously logged
    output_file="$(dirname "$0")/OUTPUT"
    sed -i '/U9=/d' "$output_file"

    # Log that the vulnerability is not present
    echo "U9=false" >> "$output_file"
fi

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
# U15
# 모든 파일 중 world-writable 파일의 존재 여부 확인
world_writable_files=$(find / -type f -perm -o+w 2>/dev/null)

output_file="$(dirname "$0")/OUTPUT"
grep -q "U15=true" "$output_file"
u15_exists=$?

if [ -n "$world_writable_files" ]; then
    echo "경고: World-writable 파일이 존재합니다."

    if [ $u15_exists -ne 0 ]; then
        # 기존에 기록된 U15 취약점을 출력 파일에서 제거
        sed -i '/U15=/d' "$output_file"

        # 취약점을 출력 파일에 기록
        echo "U15=true" >> "$output_file"
    fi
else
    if [ $u15_exists -eq 0 ]; then
        # 기존에 기록된 U15 취약점을 출력 파일에서 제거
        sed -i '/U15=/d' "$output_file"
    fi

    # 취약점이 존재하지 않음을 출력 파일에 기록
    echo "U15=false" >> "$output_file"
fi
non_existent_device="/dev/non_existent_device"

# Check if the non-existent device exists
if [ -e "$non_existent_device" ]; then
    # Remove the U16 vulnerability from the output file if it was previously logged
    output_file="$(dirname "$0")/OUTPUT"
    sed -i '/U16=/d' "$output_file"

    # Log that the vulnerability is not present
    echo "U16=false" >> "$output_file"
else
    # Log the vulnerability to the output file
    output_file="$(dirname "$0")/OUTPUT"
    echo "U16=true" >> "$output_file"
fi
