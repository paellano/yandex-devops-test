#!/usr/bin/env bash

DIR="$1"
DAYS="$2"

usage() {
  echo "Usage: $0 /path/to/logs DAYS"
  echo "  /path/to/logs - directory with log files"
  echo "  DAYS - delete .log files older than this number of days"
  exit 1
}

# 1. Check arguments
if [ -z "$DIR" ] || [ -z "$DAYS" ]; then
  usage
fi

# 2. Check directory exists
if [ ! -d "$DIR" ]; then
  echo "Error: directory '$DIR' does not exist"
  exit 1
fi

# 3. Find .log files older than N days
FILES=$(find "$DIR" -type f -name "*.log" -mtime +"$DAYS")

if [ -z "$FILES" ]; then
  echo "No .log files older than $DAYS days found in '$DIR'."
  exit 0
fi

echo "The following files will be processed:"
echo "$FILES"
echo

# 4. Ask for confirmation
read -r -p "Delete these files? (y/n): " ANSWER

if [ "$ANSWER" = "y" ] || [ "$ANSWER" = "Y" ]; then
  printf '%s\n' "$FILES" | xargs -r rm -f
  echo "Files deleted."
else
  echo "Operation cancelled."
fi

