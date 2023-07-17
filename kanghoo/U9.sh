#!/bin/bash

output_file="$(dirname "$0")/OUTPUT"

# U9
# /etc/hosts 파일의 소유권과 퍼미션 확인
file_owner=$(stat -c '%U' /etc/hosts)
file_permissions=$(stat -c '%a' /etc/hosts)

# 파일 소유자가 root가 아니거나 퍼미션이 600보다 큰 경우 경고 메시지 출력
if [ "$file_owner" != "root" ] || [ "$file_permissions" -gt 600 ]; then
    echo "경고: /etc/hosts 파일이 root 소유가 아니거나 600보다 큰 퍼미션을 가지고 있습니다."

    # 취약점을 출력 파일에 기록
    echo "U9=true" > "$output_file"
else
    # 이전에 기록된 U9 취약점을 출력 파일에서 제거
    sed -i '/U9=/d' "$output_file"

    # 취약점이 없음을 출력 파일에 기록
    echo "U9=false" >> "$output_file"
fi