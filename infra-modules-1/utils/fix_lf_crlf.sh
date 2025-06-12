#!/bin/bash

# Function to check if a file has CRLF line endings
check_crlf() {
  if file "$1" | grep -q "CRLF"; then
    return 0
  else
    return 1
  fi
}

# Function to convert CRLF to LF
convert_to_lf() {
  sed -i 's/\r$//' "$1"
  echo "Converted $1 to LF line endings."
}

# Check if a directory is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Check if the directory exists
if [ ! -d "$1" ]; then
  echo "Directory $1 does not exist."
  exit 1
fi

# Iterate over all files in the directory
for file in "$1"/*; do
  if [ -f "$file" ]; then
    # Check if the file has CRLF line endings and convert if necessary
    if check_crlf "$file"; then
      convert_to_lf "$file"
    else
      echo "File $file already has LF line endings."
    fi
  fi
done