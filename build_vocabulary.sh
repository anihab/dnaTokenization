#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-512
#SBATCH -t 5:00:00
#SBATCH --ntasks-per-node=128
#SBATCH --job-name=vocab
#SBATCH --mail-user=anisa.habib@utah.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH -o /ocean/projects/bio230026p/ahabib/SCRIPTS/tests%j.outerror
set -x
# Load Modules 
module purge
nvidia-smi
module load cuda/11.7.1
nvidia-smi
module load anaconda3/2022.10
echo "starting DNABERT env on conda"
source activate dnabert

echo "TIME: Start: = `date +"%Y-%m-%d %T"`"

python3 buildVocab.py

echo "TIME: End: = `date +"%Y-%m-%d %T"`" 
