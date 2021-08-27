#!/bin/bash
#SBATCH --job-name=miniBUDE_cuda
#SBATCH --account=project_2002078
#SBATCH --partition=gputest
#SBATCH --time=00:15:00
#SBATCH -e minibude_cuda_v100_error
#SBATCH -o minibude_cuda_v100_out
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=8000
#SBATCH --gres=gpu:v100:1

for i in {1..10};do
        echo $i
        time ./bude --device 1 --deck ../big5 --numposes 983040
done
