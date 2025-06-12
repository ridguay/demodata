
# This script takes an input file and crashes if the file has windows file endings.
# This can be used to check if the init scripts for Databricks have proper line endings

# Check if input file does exist
if [ ! -f "$1" ]; then
  echo "$1 not a file."
  exit 1
fi

# Get the file information
# If the file endings are wrong the folling value is returned: ASCII text, with CRLF line terminators
file_information=$(file --brief $1)

# If CRLF is in the output of the file information, the file endings are wrong
if [[ "$file_information" == *"CRLF"* ]]; then
  echo "File $1 contains wrong file endings"
  echo "Got: $file_information"
  exit 1
fi