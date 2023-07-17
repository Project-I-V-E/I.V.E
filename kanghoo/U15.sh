#!/bin/bash

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