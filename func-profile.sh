#!/bin/bash

set -o functrace

file_to_profile="$1"
profile_log="$file_to_profile.profile"
separator=","
funcseparator=" "
shift 1

previous=""

function profile_before() {
  start_time=$(date +%s%3N)
  function_name="$1"
  if [ ! -z "$function_name" ] || [ ! -z "$previous" ] ; then
    echo "${start_time}${separator}$@" >> "$profile_log"
  fi
  previous="$function_name"
}

truncate -s 0 "$profile_log"
trap 'profile_before ${FUNCNAME[*]}' DEBUG
. $file_to_profile $@ 2>&1 1> /dev/null
trap - DEBUG
awk -v sep="$separator" -F "$separator" '
    NR == 1{profiled_start_time = $1; profiled_funcname = $2; next}
    NR > 1 {
      line_run_time = ($1 - profiled_start_time)/1000.0; 
      if (profiled_funcname != "") {
        print line_run_time sep profiled_funcname
      }
      profiled_start_time = $1; profiled_funcname = $2; 
    }
' "$profile_log" > "$profile_log.tmp"
sed -i "s/$funcseparator/$separator/g" "$profile_log.tmp"
awk -v sep="$separator" -F "$separator" '
  {
    for (i=2; i<=NF; i++) {
      total_time[$i] += $1
    }
    cumulative_time[$2] += $1
  }
  END {
    for (funcname in total_time) {
      if (funcname == "source") {
        continue
      }
      print funcname sep total_time[funcname] sep cumulative_time[funcname]
    }
  }
' "$profile_log.tmp" | sort -r -t"$separator" -nk2 > "$profile_log"
cat "$profile_log"
