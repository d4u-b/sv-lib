#!/bin/bash

# Usage function to display help
usage() {
    echo "Usage: $0 <directory> <search_string> [replace_string] [+s | +r]"
    echo "Options:"
    echo "  +s    Search only (no replace_string needed)"
    echo "  +r    Search and replace (requires replace_string)"
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -lt 3 ] || [ "$#" -gt 4 ]; then
    usage
fi

# Assign arguments to variables
DIRECTORY=$1
SEARCH_STRING=$2

# Check if the option is valid and set the REPLACE_STRING if required
if [ "$3" == "+s" ]; then
    OPTION="+s"
elif [ "$3" == "+r" ] && [ "$#" -eq 4 ]; then
    OPTION="+r"
    REPLACE_STRING=$4
else
    usage
fi

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Directory not found!"
    exit 1
fi

# Find files containing the search string
grep -rn "$SEARCH_STRING" "$DIRECTORY"
FILES=$(grep -rl "$SEARCH_STRING" "$DIRECTORY")

if [ "$OPTION" == "+s" ]; then
    # Search only
    if [ -z "$FILES" ]; then
        echo "No files found containing the string '$SEARCH_STRING'."
    else
        echo "Files containing the string '$SEARCH_STRING':"
        echo "$FILES"
    fi
else
    # Search and replace
    if [ -z "$FILES" ]; then
        echo "No files found containing the string '$SEARCH_STRING'."
    else
        echo "$FILES" | while IFS= read -r FILE; do
            sed -i.bak "s/${SEARCH_STRING}/${REPLACE_STRING}/g" "$FILE"
            echo "Replaced '${SEARCH_STRING}' with '${REPLACE_STRING}' in file '${FILE}'."
        done
        echo "Replacement complete. Backup files with .bak extension have been created."
    fi
fi
