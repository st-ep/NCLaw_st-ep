#!/bin/bash

#SBATCH -J compile-trellis               # Job name
#SBATCH -o log.%j                         	 # Name of stdout output file (%j expands to jobId)
#SBATCH -p gpu-a100-dev                               # Queue name
#SBATCH -N 1                                 # Total number of nodes requested (56 cores/node)
#SBATCH -n 1                                 # Total number of mpi tasks requested
#SBATCH -t 01:00:00                          # Run time (hh:mm:ss)
#SBATCH -A BCS20003							 # Project charge code

# Load the requisite modules
module load gcc/11.2.0
module load cuda/12.2
module load python3

# Activate the nclaw environment
python3 -m venv nclaw
source nclaw/bin/activate
export CUDA_PATH=$TACC_CUDA_DIR

# Execute the python script 
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117
pip install numpy scipy pyvista hydra-core trimesh einops tqdm psutil tensorboard
. ./build.sh

