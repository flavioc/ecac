#!/bin/sh

USER=$1
PASSWORD=$2
DIR=SimpleCart

run_cart()
{
  M=$1
  N=$2
  FILE="m${M}_n$N"

  OPTIONS="-M $M -N $N"
  echo "SimpleCart $OPTIONS"

  { time java -Xmx512m SimpleCart $USER $PASSWORD "$OPTIONS"; } &> $DIR/$FILE.txt
}

run_part()
{
  M=$1

  run_cart $M 5
  run_cart $M 10
  run_cart $M 15
  run_cart $M 20
}

mkdir -p $DIR
run_part 2
run_part 3
run_part 5
run_part 7
run_part 10
