#!/bin/bash

cp template3bude.plot exec.plot
sed -i "s/file.dat/${1}.dat/g" exec.plot 

sed -i "s/output.png/${2}.png/g" exec.plot

sed -i "s/dotmin/${3}/g" exec.plot

sed -i "s/dotmax/${4}/g" exec.plot

sed -i "s/dottmin/${5}/g" exec.plot

sed -i "s/dottmax/${6}/g" exec.plot

sed -i "s/allmin/${7}/g" exec.plot

sed -i "s/allmax/${8}/g" exec.plot

sed -i "s/modelname/${9}/g" exec.plot

gnuplot < exec.plot

