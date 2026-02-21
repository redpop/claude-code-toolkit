#!/bin/bash
# Validates shell scripts after Write/Edit operations using ShellCheck.
# Reads hook input from stdin, extracts file path, validates if .sh.
# Exit 0 = ok, Exit 2 = blocking error (ShellCheck findings).

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path','') or d.get('tool_response',{}).get('filePath',''))" 2>/dev/null)

# Skip if no file path or not a shell script
[ -z "$FILE_PATH" ] && exit 0
case "$FILE_PATH" in *.sh) ;; *) exit 0 ;; esac

# Skip if file doesn't exist (was deleted)
[ ! -f "$FILE_PATH" ] && exit 0

# Skip if shellcheck is not installed
command -v shellcheck > /dev/null 2>&1 || exit 0

# Validate with ShellCheck
if ! shellcheck "$FILE_PATH" 2>&1; then
  echo "ShellCheck errors in $FILE_PATH" >&2
  exit 2
fi

exit 0
