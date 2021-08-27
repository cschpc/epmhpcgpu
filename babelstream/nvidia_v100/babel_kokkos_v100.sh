#!/bin/bash
#SBATCH --job-name=babel_kokkos
#SBATCH --account=project
#SBATCH --partition=gpumedium
#SBATCH --time=00:02:00
#SBATCH -e babel_kokkos_v100_error
#SBATCH -o babel_kokkos_v100_out
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=8000
#SBATCH --gres=gpu:v100:1

for i in {1..10}; do
        echo $i
        srun -n 1 ./kokkos-stream;
        sleep 5;
done

