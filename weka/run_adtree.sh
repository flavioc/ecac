#!/bin/sh

USER=$1
PASSWORD=$2
DIR=ADTree

run_adtree()
{
  TYPE=$1
  NAME=$2
  ITER=$3

  OPTIONS="-E $TYPE -B $ITER"
  echo "ADTree $OPTIONS"
  { time java ADTree $USER $PASSWORD "$OPTIONS"; } &> $DIR/$NAME$ITER.txt
}

run_expand()
{
  TYPE=$1
  NAME=$2

  run_adtree $TYPE $NAME 2
  run_adtree $TYPE $NAME 5
  run_adtree $TYPE $NAME 10
  run_adtree $TYPE $NAME 15
  run_adtree $TYPE $NAME 20
  run_adtree $TYPE $NAME 25
  run_adtree $TYPE $NAME 30
  run_adtree $TYPE $NAME 35
  run_adtree $TYPE $NAME 40
  run_adtree $TYPE $NAME 45
}

mkdir -p $DIR
run_expand "-3" "all"
run_expand "-2" "weight"
run_expand "-1" "z_pure"
run_expand "0" "random"

