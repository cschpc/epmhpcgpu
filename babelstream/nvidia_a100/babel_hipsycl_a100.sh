#!/bin/bash
#SBATCH --job-name=babel_hipsycl
#SBATCH --account=project_2001659
#SBATCH --partition=gpusmall
#SBATCH --time=00:10:00
#SBATCH -o babel_hipsycl_a100_out
#SBATCH -e babel_hipsycl_a100_error
#SBATCH --nodes=1
#SBATCH --gres=gpu:a100:1


for i in {1..10}; do
        echo $i
        srun -n 1 ./sycl-stream;
        sleep 5;
done

