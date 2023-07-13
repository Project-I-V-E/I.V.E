#!/bin/bash


danger=3

while IFS= read -r line
do
    case $line in
        "User "*)
            user=$(echo "$line" | awk '{print $2}')
            if [[ $user != "root" ]]; then
                danger=0
            else
                danger=1
            fi
            echo "User = $user = $danger"
            continue
            ;;
        "Group "*)
            group=$(echo "$line" | awk '{print $2}')
            if [[ $group != "root" ]]; then
                danger=0
            else
                danger=1
            fi
            echo "Group = $group = $danger"
            continue
            ;;
    esac
done < "../../../../../etc/apache2/apache2.conf"

echo "danger=$danger"

script_name=$(basename "$0")
script_name="${script_name%.sh}"

output_file="$(dirname "$0")/output.txt"  
echo "$script_name=$danger" >> "$output_file"
