
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
Enter a number for the multiplication table: 3
Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): p
Enter the starting number (between 1 and 10): 2
Enter the ending number (between 1 and 10): 5
Choose a table style:
- List Form For Loop
- C-style For Loop
Enter your choice (1/2): 2

Multiplication table (C-style) for 3 from 2 to 5:
3 x 2 = 6
3 x 3 = 9
3 x 4 = 12
3 x 5 = 15
```

## Script
```bash
#!/bin/bash

# Function to generate the multiplication table using a list form for loop
generate_table_list_style() {
    number=$1
    start=$2
    end=$3

    echo "Multiplication table (List Form) for $number from $start to $end:"
    
    # Using list form for loop
    for i in $(seq $start $end); do
        result=$((number * i))
        echo "$number x $i = $result"
    done
}

# Function to generate the multiplication table using C-style for loop
generate_table_c_style() {
    number=$1
    start=$2
    end=$3

    echo "Multiplication table (C-style) for $number from $start to $end:"

    # Using C-style for loop
    for ((i=start; i<=end; i++)); do
        result=$((number * i))
        echo "$number x $i = $result"
    done
}

# Function to choose the table style
choose_table_style() {
    echo "Choose a table style:"
    echo "1. List Form For Loop"
    echo "2. C-style For Loop"
    read -p "Enter your choice (1/2): " style_choice

    case $style_choice in
        1)
            generate_table_list_style $1 $2 $3
            ;;
        2)
            generate_table_c_style $1 $2 $3
            ;;
        *)
            echo "Invalid choice, defaulting to List Form For Loop."
            generate_table_list_style $1 $2 $3
            ;;
    esac
}

# Main script flow
while true; do
    read -p "Enter a number for the multiplication table: " num

    # Prompt the user for full or partial table
    read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " choice

    if [[ "$choice" == "f" ]]; then
        start=1
        end=10
        choose_table_style $num $start $end
    elif [[ "$choice" == "p" ]]; then
        read -p "Enter the starting number (between 1 and 10): " start
        read -p "Enter the ending number (between 1 and 10): " end

        # Validate the range
        if [[ $start -gt $end || $start -lt 1 || $end -gt 10 ]]; then
            echo "Invalid range. Showing full table instead."
            start=1
            end=10
        fi

        choose_table_style $num $start $end
    else
        echo "Invalid input. Showing full table instead."
        start=1
        end=10
        choose_table_style $num $start $end
    fi

    # Ask if the user wants to continue
    read -p "Do you want to generate another table? (y/n): " continue_choice
    if [[ "$continue_choice" != "y" ]]; then
        echo "Goodbye!"
        break
    fi
done
```