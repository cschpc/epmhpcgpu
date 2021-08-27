#!/bin/bash

cp templateall.plot exec.plot
sed -i "s/file.dat/${1}.dat/g" exec.plot 

sed -i "s/output.png/${2}.png/g" exec.plot

sed -i "s/v100min/${3}/g" exec.plot

sed -i "s/v100max/${4}/g" exec.plot

sed -i "s/mi1002min/${5}/g" exec.plot

sed -i "s/mi1002max/${6}/g" exec.plot

sed -i "s/mi1001min/${7}/g" exec.plot

sed -i "s/mi1001max/${8}/g" exec.plot

sed -i "s/a1002min/${9}/g" exec.plot

sed -i "s/a1002max/${10}/g" exec.plot


sed -i "s/a100min/${11}/g" exec.plot

sed -i "s/a100max/${12}/g" exec.plot

sed -i "s/modelname/${13}/g" exec.plot

gnuplot < exec.plot

