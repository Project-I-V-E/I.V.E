#!/bin/bash

output_file="$(dirname "$0")/OUTPUT"

if [ ! -f "$output_file" ]; then
    touch "$output_file"
fi


# U9
bash "$(dirname "$0")/U9.sh"
if grep -q "U9=true" "$output_file"; then
    echo "U9 취약점이 감지되었습니다. 문제를 수정하고 스크립트를 다시 실행하세요."
    exit 1
fi

# U10
bash U10.sh
if grep -q "U10=true" "$output_file"; then
    echo "U10 취약점이 감지되었습니다. 문제를 수정하고 스크립트를 다시 실행하세요."
    exit 1
fi

# U11
bash U11.sh
if grep -q "U11=true" "$output_file"; then
    echo "U11 취약점이 감지되었습니다. 문제를 수정하고 스크립트를 다시 실행하세요."
    exit 1
fi

# U12
bash U12.sh
if grep -q "U12=true" "$output_file"; then
    echo "U12 취약점이 감지되었습니다. 문제를 수정하고 스크립트를 다시 실행하세요."
    exit 1
fi

# U15
bash U15.sh
if grep -q "U15=true" "$output_file"; then
    echo "U15 취약점이 감지되었습니다. 문제를 수정하고 스크립트를 다시 실행하세요."
    exit 1
fi

# ... 추가 취약점 스크립트와 해당 검사 추가 ...

# 최종 단계: 요약 출력
if [ -f "$output_file" ]; then
    echo "취약점 분석이 완료되었습니다. 출력 파일을 확인하세요: $output_file"
else
    echo "취약점이 발견되지 않았습니다."
fi