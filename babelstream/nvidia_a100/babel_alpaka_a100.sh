#!/bin/bash
#SBATCH --job-name=babel_alpaka
#SBATCH --account=project
#SBATCH --partition=gpusmall
#SBATCH -o babel_alpaka_a100_out
#SBATCH -e babel_alpaka_a100_error
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --gres=gpu:a100:1


for i in {1..10}; do
        echo $i
        srun -n 1 ./cupla-stream;
        sleep 5;
done

