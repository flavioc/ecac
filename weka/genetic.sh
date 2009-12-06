#!/bin/sh

java Bayes $1 $2 "weka.classifiers.bayes.net.search.local.GeneticSearch -- -L 3 -A 3 -U 2 -C -M -R 1" 1
