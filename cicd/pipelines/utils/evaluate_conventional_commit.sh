#!/bin/bash

# Specify the CLI arguments as follows: "key=value"
# Example usage:
# bash evaluate_conventional_commit.sh "types=feat|fix" "allow_revert=1" "commit_text=fix: message"

# Read all input arguments from the CLI
for ARGUMENT in "$@"
do
  KEY=$(echo $ARGUMENT | cut -f1 -d=)
  KEY_LENGTH=${#KEY}
  VALUE="${ARGUMENT:$KEY_LENGTH+1}"
  export "$KEY"="$VALUE"
done

if [[ -z $types ]]
then
  echo "types argument not given, format: type1|type2|type3"
  exit 1
fi

if [[ -z $allow_revert ]]
then
  echo "allow_revert argument not given, options: 0 or 1"
  exit 1
fi

if [[ -z $commit_text ]]
then
  echo "commit_text argument not given"
  exit 1
fi

##### EXPLANATION #####
# Correct regex pattern: `^(revert: )|^(feat|fix)(\(.+\))?: (\w.*)`
# ^ => Start of string
# ^(revert: ) => Allow `revert: ` in exactly that syntax, so no scope allowed at the start of the string

# ^(feat|fix) => Allow exactly one of the types specified at the start of the string

# (\(.+\)) => The scope should be in the syntax of: `(scope)` and there has to be at least 1 character within the brackets.
# ? => The previous pattern may be omitted.
# (\(.+\))? => The scope (as defined above) may be omitted for the string to still match.

# `: ` => (Note the space after the colon) Require a colon and space after the type (and scope)
# (\w.*) => at least one word should follow the colon on the same line as the description. 

# `^(revert: )|^(feat|fix)(\(.+\))?: ` => The string has to start with `revert: ` OR
#   it has to start with feat or fix, followed by an optional scope in the form of: (scope), followed by `: `
##### EXPLANATION #####

##### LOGIC #####
regexp_revert=""
if [ $allow_revert -eq 1 ]
then
  # Revert is allowed, so allow `revert: ` as start of the title
  regexp_revert="^(revert: )|"
fi

# Title has to start with one of the specified types
regexp_type="^($types)"
# The scope (if present) should be within brackets and should be at least 1 character long
regexp_scope="(\(.+\))?: "

# Ensure the title and scope are followed by a description of at least one word
regexp_description="(\w.*)"

# Combine all separate patterns into one for testing
regexp_commit_prefix="${regexp_revert}${regexp_type}${regexp_scope}${regexp_description}"

# If the title doesn't match the pattern, it's not according to the convention
if ! [[ "$commit_text" =~ $regexp_commit_prefix ]]
then
  echo "######################"
  echo "Commit text not according to convention."
  echo "Convention: type(scope): message"
  echo "Regex checked: $regexp_commit_prefix"
  echo "Found message: $commit_text"
  echo "Allowed types: $types"
  echo "######################"
  exit 1
else
  echo "######################"
  echo "Message \`$commit_text\` accepted."
  echo "######################"
fi
