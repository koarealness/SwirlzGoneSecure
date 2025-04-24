#!/bin/bash

SRC8="/System/Cryptexes/App/usr/share/man/man8"
SRC1="/System/Cryptexes/App/usr/share/man/man1"
DEST="/Volumes/Image Volume/Patient-0/safari_trace_quarantine"
LOG="/Volumes/Image Volume/Patient-0/safari_trace/trace_log.txt"

mkdir -p "$DEST"
mkdir -p "$(dirname "$LOG")"

echo "==== Safari Cryptex Quarantine Log ====" >> "$LOG"
date >> "$LOG"

# Function to scan and copy files
scan_and_quarantine() {
  local DIR=$1
  local SECTION=$2
  cd "$DIR" 2>/dev/null || return

  for file in *Safari*.${SECTION} *safaridriver*.${SECTION} *PasswordBreach*.${SECTION}; do
    if [ -f "$file" ]; then
      echo "Quarantining [$SECTION]: $file"
      cp "$file" "$DEST/"
      echo "[$SECTION] Quarantined $file from $DIR" >> "$LOG"
    fi
  done
}

scan_and_quarantine "$SRC8" "8"
scan_and_quarantine "$SRC1" "1"

echo "All suspicious manpages scanned and copied. Log saved to: $LOG"
