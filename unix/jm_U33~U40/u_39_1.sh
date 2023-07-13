#!/bin/bash
danger=3

# httpd.conf
conf_file="../../../../../etc/apache2/apache2.conf"

# Options
options=$(grep -oP '(?<=Options )\S+' "$conf_file")  

# Options
echo "Options: $options"

# "FollowSymLinks" "-FollowSymLinks"
if [[ $options == *"FollowSymLinks"* ]] || [[ $options != *"-FollowSymLinks"* ]]; then
  danger=0
else
  danger=1
fi

# Print the value of the danger variable
echo "danger=$danger"

script_name=$(basename "$0")
script_name="${script_name%.sh}"

output_file="$(dirname "$0")/output.txt"  
echo "$script_name=$danger" >> "$output_file"
