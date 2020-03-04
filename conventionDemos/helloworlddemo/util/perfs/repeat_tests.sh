#!/bin/bash

script=$1

i=0
while [ $i -lt 100 ]
do
	time sh ./$script
	i=$[$i+1]
done
