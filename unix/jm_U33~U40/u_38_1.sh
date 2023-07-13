#!/bin/bash

# Receive the first and second paths as variables
path1="../../../../../etc/apache2/htdocs/manual"
path2="../../../../../etc/apache2/manual"

# Initialize the safety variable
danger=3

# Check if the first path exists
if [ -e "$path1" ]; then
    danger=1
    echo "path1 o"
else
    danger=0
    echo "path1 x"
fi

# Check if the second path exists
if [ -e "$path2" ]; then
    if [ $danger -eq 0 ]; then  
        danger=1
        echo "path1 x, path2 o"
    fi
else
    danger=0
    echo "path1 x, path2 x"
fi

# Print the value of the safety variable
echo "danger=$danger"

script_name=$(basename "$0")
script_name="${script_name%.sh}"

output_file="$(dirname "$0")/output.txt"  
echo "$script_name=$danger" >> "$output_file"
