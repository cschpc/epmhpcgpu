#!/bin/bash
#SBATCH --job-name=babel_omp_mi100
#SBATCH --time=00:05:00
#SBATCH --partition=MI100
#SBATCH -o babel_omp_mi100_out
#SBATCH -e babel_omp_mi100_err
#SBATCH --nodes=1


for i in {1..10}; do
	echo $i
	srun -n 1 ./omp-stream;
	sleep 5;
done
