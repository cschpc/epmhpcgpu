#!/bin/bash

cp template3bude.plot exec.plot
sed -i '' -e "s/file.dat/${1}.dat/g" exec.plot 

sed -i '' -e "s/output.png/${2}.png/g" exec.plot

sed -i '' -e "s/dotmin/${3}/g" exec.plot

sed -i '' -e "s/dotmax/${4}/g" exec.plot

sed -i '' -e "s/allmin/${5}/g" exec.plot

sed -i '' -e "s/allmax/${6}/g" exec.plot

sed -i '' -e "s/modelname/${7}/g" exec.plot

gnuplot < exec.plot

