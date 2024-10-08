
# Bash Script For Generating A Multiplication Table

## Project Overview
This project demonstrates the use of Bash scripting to generate a multiplication table for any number entered by the user. The script utilizes user input, loops, and conditional logic to create both full and partial multiplication tables.


## Project Description
The script prompts a user to enter a number and then asks if they prefer to see a full multiplication table from 1-10
or a partial table within a specified range. It then output the result to the user based on the user's choice.


## Features:
- User can generate either a full or partial multiplication table.
- Two distinct styles of generating the table are available:
  - **List Form For Loop**: Using the `for i in $(seq)` loop.
  - **C-style For Loop**: Using the `for ((i=start; i<=end; i++))` loop.
- Input validation to ensure proper range selection for partial tables.
- Interactive user experience with the option to generate another table without restarting the script.


## Script flow
- Prompt the user to enter a number for a multiplication table.

- Ask if they want a full or partial table
    - If partial, prompt the user for start and end numbers of the range.

- Validate the range inputs and handle invalid or out-of-bound enteries.

- Generate and output the multiplication table based on the specified range

- Provides clear output formatting for ease of reading.

- Enhanced user interaction by incorporating additional checks or fetaures by repeating the program for another number without necessarily restarting the script.

- Creativity in the output by displaying options offering different formatting stylesfor the table display and let the user choose.


## Prerequisites
Ensure that you have Bash installed on your system. This script is designed to run in a Unix-like environment such as Linux or macOS.


## How to Run the Script
1. Clone the repository or copy the script to your local machine.

2. Make the script executable using the following command:
```bash
chmod +x multiplication_table.sh
```

3. Run the script:
```bash
./multiplication_table.sh
```


## Example Output
1. Full Multiplication Table:

```bash
Enter a number for the multiplication table: 3
Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): f
Choose a table style:
- List Form For Loop
- C-style For Loop
Enter your choice (1/2): 1

Multiplication table (List Form) for 3 from 1 to 10:
3 x 1 = 3
3 x 2 = 6
3 x 3 = 9
3 x 4 = 12
3 x 5 = 15
3 x 6 = 18
3 x 7 = 21
3 x 8 = 24
3 x 9 = 27
3 x 10 = 30
```

2. Partial Multiplication Table:
```bash
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
```

## Error Handling:
Adequate Input validation by adding specific error messages and prompting the user to re-enter valid inputs if they are out of range, rather than defaulting to a full table immediately.


## Code Modularity:
Having the main script broken down into smaller, modular functions to improve readability and maintainability. Each task (getting user input, validating input, generating the table, etc.) will have its own function.