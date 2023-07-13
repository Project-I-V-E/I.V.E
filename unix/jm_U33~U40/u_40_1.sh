#!/bin/bash

danger=3

# httpd.conf
conf_file="../../../../../etc/apache2/apache2.conf"

# LimitRequestBody
limit=$(grep -oP '(?<=LimitRequestBody )\S+' "$conf_file")

# LimitRequestBody
echo "LimitRequestBody: $limit"

# config safety
if [[ -z "$limit" ]] || [[ $limit -lt 5000000 ]]; then
  danger=1
elif [[ $limit -ge 5000000 ]]; then
  danger=0
fi

# Print the value of the danger variable
echo "danger=$danger"

script_name=$(basename "$0")
script_name="${script_name%.sh}"

output_file="$(dirname "$0")/output.txt"  
echo "$script_name=$danger" >> "$output_file"
