#!/bin/bash

set -o functrace

file_to_profile="$1"
profile_log="$file_to_profile.profile"
separator=","
shift 1

previous=""

function profile_before() {
  start_time=$(date +%s%3N)
  bash_source="$1"
  function_name="$2"
  if [ ! -z "$function_name" ] || [ ! -z "$previous" ] ; then
    echo "${start_time}${separator}${bash_source}${separator}${function_name}" >> "$profile_log"
  fi
  previous="$function_name"
}

truncate -s 0 "$profile_log"
trap 'profile_before "$BASH_SOURCE" $FUNCNAME' DEBUG
. $file_to_profile $@ 2>&1 1> /dev/null
trap - DEBUG
awk -v sep="$separator" -F "$separator" '
    NR == 1{profiled_start_time = $1; profiled_filename = $2; profiled_funcname = $3; next}
    NR > 1 {
      line_run_time = ($1 - profiled_start_time)/1000.0; 
      if (profiled_funcname != "") {
        total_time["file=" profiled_filename sep "funcname=" profiled_funcname ] += line_run_time;
      }
      profiled_start_time = $1; profiled_filename = $2; profiled_funcname = $3; 
    }
    END {
      for (key in total_time) print total_time[key] sep key 
    }
' "$profile_log" | sort -r -t "$separator" -nk1 > "$profile_log.tmp"
awk -v sep="$separator" -F "$separator" '{print "total_time=" $1 sep $2 sep $3}' "$profile_log.tmp" > "$profile_log"
cat "$profile_log"
