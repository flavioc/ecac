#!/bin/sh

USER=$1
PASSWORD=$2
DIR=RandomForest

run_rf()
{
  NTREES=$1
  FILE=$NTREES

  OPTIONS="-I $NTREES"
  echo "RandomForest $OPTIONS"

  { time java -Xmx1G RandomForest $USER $PASSWORD "$OPTIONS"; } &> $DIR/$FILE.txt
}

mkdir -p $DIR
#run_rf 2
#run_rf 3
#run_rf 4
#run_rf 5
#run_rf 7
#run_rf 10
#run_rf 15
#run_rf 20
#run_rf 40
#run_rf 60
#run_rf 80
#run_rf 100
#run_rf 150
#run_rf 200
run_rf 400
