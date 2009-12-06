#/bin/sh

java Bayes $1 $2 "weka.classifiers.bayes.net.search.local.SimulatedAnnealing -- -U 50 -A 20 -D 0.4 -R 1" 10
