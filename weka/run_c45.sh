#!/bin/sh

run_c45()
{
  OPTIONS=$1
  FILE=$2
  echo "C45 $OPTIONS"
  { time java C45 root nutshell111 "$OPTIONS"; } &> C45/$FILE.txt
}

mkdir -p C45
run_c45 "-U" unpruned
run_c45 "-C 0.05" 005
run_c45 "-C 0.1" 010
run_c45 "-C 0.15" 015
run_c45 "-C 0.2" 020
run_c45 "-C 0.25" 025
run_c45 "-C 0.3" 030
run_c45 "-C 0.35" 035
run_c45 "-C 0.4" 040
run_c45 "-C 0.45" 045
run_c45 "-C 0.5" 050
run_c45 "-C 0.55" 055
run_c45 "-C 0.6" 060
run_c45 "-C 0.7" 070
run_c45 "-C 0.8" 080
run_c45 "-C 0.9" 090
run_c45 "-C 0.95" 095
