#!/bin/bash

# Receive the first and second paths as variables
path1="../../../../../etc/apache2/htdocs/manual"
path2="../../../../../etc/apache2/manual"

# Initialize the safety variable
danger=3

# Check if the first path exists
if [ -e "$path1" ]; then
    danger=1
else
    danger=0
fi
    # Check if the second path exists

if [ -e "$path2" ]; then
    danger=1
else
    danger=0
fi

# Print the value of the safety variable
echo "danger=$danger"

script_name=$(basename "$0")
script_name="${script_name%.sh}"

echo "$script_name=$danger" >> "$output_file"