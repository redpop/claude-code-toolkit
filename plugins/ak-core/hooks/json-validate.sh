#!/bin/bash
# Validates JSON files after Write/Edit operations.
# Reads hook input from stdin, extracts file path, validates if .json.
# Exit 0 = ok, Exit 2 = blocking error (invalid JSON).

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path','') or d.get('tool_response',{}).get('filePath',''))" 2>/dev/null)

# Skip if no file path or not a JSON file
[ -z "$FILE_PATH" ] && exit 0
case "$FILE_PATH" in *.json) ;; *) exit 0 ;; esac

# Skip if file doesn't exist (was deleted)
[ ! -f "$FILE_PATH" ] && exit 0

# Validate JSON syntax
if ! python3 -m json.tool "$FILE_PATH" > /dev/null 2>&1; then
  echo "JSON syntax error in $FILE_PATH" >&2
  exit 2
fi

exit 0
