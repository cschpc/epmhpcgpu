#!/bin/bash
#SBATCH --job-name=babel_cuda
#SBATCH --account=project_2001659
#SBATCH --partition=gpusmall
#SBATCH -o minibude_cuda_a100_out
#SBATCH -e minibude_cuda_a100_error
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --gres=gpu:a100:1


for i in {1..10};do
        echo $i
        time ./bude --device 1 --deck ../big5 --numposes 983040
done

