#!/bin/sh

java Bayes $1 $2 "weka.classifiers.bayes.net.search.local.HillClimber -- -P 100" 5
