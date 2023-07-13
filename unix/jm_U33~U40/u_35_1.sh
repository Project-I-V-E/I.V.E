#!/bin/bash

danger=3

# httpd.conf .
file="../../../../../etc/apache2/apache2.conf"

# Read the directory tags in the file
while IFS= read -r line
do
    if [[ $line == "<Directory "* ]]; then
        dir_line=$line
    elif [[ $line == "</Directory>" ]]; then
        dir_line=""
    elif [[ $dir_line != "" ]]; then
        if [[ $line == "Options "* ]]; then
            options=$(echo "$line" | awk '{print $2}')
            echo "Options value: $options"
            if [[ $options != *"Indexes"* ]]; then
                danger=0
                echo "Setting danger to 0"
            else
                danger=1
                echo "Setting danger to 1"
            fi
            break
        fi
    fi
done < "$file"

# Print the value of the danger variable
echo "danger=$danger"

script_name=$(basename "$0")
script_name="${script_name%.sh}"

output_file="$(dirname "$0")/output.txt"
echo "$script_name=$danger" >> "$output_file"


