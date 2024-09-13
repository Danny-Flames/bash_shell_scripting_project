#!/bin/bash

# Function to validate input range
validate_range() {
    local start=$1
    local end=$2

    if [[ $start -lt 1 || $start -gt 10 || $end -lt 1 || $end -gt 10 || $start -gt $end ]]; then
        echo "Invalid range. Please enter a valid range between 1 and 10."
        return 1
    fi
    return 0
}

# Function to generate the multiplication table using a list form for loop
generate_table_list_style() {
    local number=$1
    local start=$2
    local end=$3

    echo "Multiplication table (List Form) for $number from $start to $end:"
    
    for i in $(seq $start $end); do
        result=$((number * i))
        echo "$number x $i = $result"
    done
}

# Function to generate the multiplication table using C-style for loop
generate_table_c_style() {
    local number=$1
    local start=$2
    local end=$3

    echo "Multiplication table (C-style) for $number from $start to $end:"

    for ((i=start; i<=end; i++)); do
        result=$((number * i))
        echo "$number x $i = $result"
    done
}

# Function to choose table style
choose_table_style() {
    echo "Choose a table style:"
    echo "1. List Form For Loop"
    echo "2. C-style For Loop"
    read -p "Enter your choice (1/2): " style_choice

    case $style_choice in
        1) generate_table_list_style $1 $2 $3 ;;
        2) generate_table_c_style $1 $2 $3 ;;
        *) 
            echo "Invalid choice, defaulting to List Form For Loop."
            generate_table_list_style $1 $2 $3 
            ;;
    esac
}

# Function to get range from user
get_range() {
    local start end
    while true; do
        read -p "Enter the starting number (between 1 and 10): " start
        read -p "Enter the ending number (between 1 and 10): " end

        if validate_range $start $end; then
            break
        fi
    done
    echo "$start $end"
}

# Function to generate table for a number
generate_table() {
    local num start end choice range

    read -p "Enter a number for the multiplication table: " num
    read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " choice

    if [[ "$choice" == "f" ]]; then
        # Offer option to set custom range for full table
        read -p "Do you want to customize the range? (y/n): " customize
        if [[ "$customize" == "y" ]]; then
            range=$(get_range)
            start=$(echo $range | cut -d ' ' -f 1)
            end=$(echo $range | cut -d ' ' -f 2)
        else
            start=1
            end=10
        fi
        choose_table_style $num $start $end
    elif [[ "$choice" == "p" ]]; then
        range=$(get_range)
        start=$(echo $range | cut -d ' ' -f 1)
        end=$(echo $range | cut -d ' ' -f 2)
        choose_table_style $num $start $end
    else
        echo "Invalid input. Showing full table instead."
        start=1
        end=10
        choose_table_style $num $start $end
    fi
}

# Main script loop
while true; do
    generate_table

    # Ask if the user wants to continue
    read -p "Do you want to generate another table? (y/n): " continue_choice
    if [[ "$continue_choice" != "y" ]]; then
        echo "Goodbye!"
        break
    fi
done
