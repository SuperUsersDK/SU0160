#!/bin/sh

A=1
B=0
while :
do
  A=$((A+1))
  if [ $A -gt 50000 ]
  then 
    A=1
    B=$((B+1))
    echo $B
  fi
done
