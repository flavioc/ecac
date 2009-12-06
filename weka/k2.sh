#!/bin/sh

java Bayes $1 $2 "weka.classifiers.bayes.net.search.local.K2 -- -P 100 -R" 10
