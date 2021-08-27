#!/bin/bash 

all=""
for k in {Copy,Mul,Add,Triad,Dot}
do
	cat $1 | grep $k | awk '{if(NR==1) {print $1"\n"$2} else print $2}' > $k.txt
	all=$all" "$k".txt"
done

paste $all > $2



