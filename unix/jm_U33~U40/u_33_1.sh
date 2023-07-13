#!/bin/bash

# Check if bind is in use
bind_status=$(systemctl is-active bind)

if [[ $bind_status == "active" ]]; then
    danger=3  # bind is in use, set danger to 3
else
    danger=0  # bind is not in use, set danger to 0
fi

# Print the value of the danger variable
echo "danger=$danger"
