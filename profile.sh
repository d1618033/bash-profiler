#!/bin/bash

set -o functrace

file_to_profile="$1"
profile_log="$file_to_profile.profile"
separator="$2"
shift 2
sortseparator='$'

function profile_before() {
  cmd_to_exe="$BASH_COMMAND"
  start_time=$(date +%s%3N)
  bash_source="$1"
  line_no="$2"
  echo "${start_time}${separator}${bash_source}${separator}${line_no}${separator}${cmd_to_exe}" >> "$profile_log"
}

truncate -s 0 "$profile_log"
trap 'profile_before "$BASH_SOURCE" $LINENO' DEBUG
. $file_to_profile $@ 2>&1 1> /dev/null
trap - DEBUG
awk -v sortsep="$sortseparator" -v sep="$separator" -F "$separator" '
    NR == 2{profiled_start_time = $1; profiled_filename = $2; profiled_linenumber = $3; profiled_command = $4; next}
    NR > 2 {
      line_run_time = ($1 - profiled_start_time)/1000.0; 
      total_time["file=" profiled_filename sep "lineno=" profiled_linenumber sep "cmd=" profiled_command] += line_run_time;
      profiled_start_time = $1; profiled_filename = $2; profiled_linenumber = $3; profiled_command = $4; 
    }
    END {
      for (key in total_time) print total_time[key] sortsep key 
    }
' "$profile_log" | sort -r -t "$sortseparator" -nk1 > "$profile_log.tmp"
awk -F "$sortseparator" -v sep="$separator" '{print "total_time=" $1 sep $2}' "$profile_log.tmp" > "$profile_log"
rm "$profile_log.tmp"
cat "$profile_log"
rm "$profile_log"
