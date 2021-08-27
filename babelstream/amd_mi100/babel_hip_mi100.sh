#!/bin/bash
#SBATCH --job-name=babel_hip
#SBATCH --time=00:05:00
#SBATCH --partition=MI100
#SBATCH -o babel_hip_mi100_out
#SBATCH -e babel_hip_mi100_error
#SBATCH --nodes=1


for i in {1..10}; do
	echo $i
	srun -n 1 ./hip-stream;
	sleep 5;
done
