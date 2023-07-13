#!/bin/bash

danger=3

# httpd.conf
conf_file="../../../../../etc/apache2/apache2.conf"

# AllowOverride
override=$(grep -oP '(?<=AllowOverride )\S+' "$conf_file")

# AllowOverride
echo "AllowOverride: $override"

# config safety
case "$override" in
  *"None"*)
    danger=1
    ;;
  *"AuthConfig"*)
    danger=0
    ;;
  *)
    danger=3
    ;;
esac

# Print the value of the safety variable
echo "danger=$danger"

script_name=$(basename "$0")
script_name="${script_name%.sh}"

output_file="$(dirname "$0")/output.txt"  
echo "$script_name=$danger" >> "$output_file"

