#!/bin/bash
#SBATCH --job-name=minibude_hip
#SBATCH --time=00:05:00
#SBATCH --partition=MI100
#SBATCH -o minibude_hip_mi100_out
#SBATCH -e minibude_hip_mi100_error
#SBATCH --nodes=1

for i in {1..10};do
        echo $i
        time ./bude --device 1 --deck ../big5 --numposes 983040
done

