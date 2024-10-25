#!/bin/bash
#SBATCH --nodes=1
#SBATCH -w notch372
#SBATCH --account=soc-gpu-np
#SBATCH --partition=soc-gpu-np
#SBATCH --mem=0
#SBATCH --job-name=covid_nt
#SBATCH --gres=gpu:a100:1
#SBATCH --time=12:00:00
#SBATCH -o /uufs/chpc.utah.edu/common/home/u1049062/OUT/covid_nt.txt
set -x

module use $HOME/MyModules
module load miniconda3
echo "starting env on conda"
source activate cs5340
conda list
nvidia-smi

data_path="/uufs/chpc.utah.edu/common/home/sundar-group1/ANISA_BACKUP_CHPC/ANISA/RAW_DATA"
output_path="/uufs/chpc.utah.edu/common/home/sundar-group2/ANISA/MODELS/DNABERT_2/finetune/output_082224"

cd /uufs/chpc.utah.edu/common/home/sundar-group2/ANISA/MODELS/DNABERT_2/finetune

mkdir $output_path/dnabert2
mkdir $output_path/dnabert1_6
mkdir $output_path/nt
echo "TIME: Start: = `date +"%Y-%m-%d %T"`"

echo "starting dnabert2"
# Evaluate DNABERT-2 on GUE
sh scripts/run_dnabert2.sh $data_path $output_path

echo "starting dnabert1"
# Evaluate DNABERT (e.g., DNABERT with 3-mer) on GUE
# 3 for 3-mer, 4 for 4-mer, 5 for 5-mer, 6 for 6-mer
sh scripts/run_dnabert1.sh $data_path 6 $output_path

echo "starting nt"
# Evaluate Nucleotide Transformers on GUE
# 0 for 500m-1000g, 1 for 500m-human-ref, 2 for 2.5b-1000g, 3 for 2.5b-multi-species
sh scripts/run_nt.sh $data_path 0 $output_path

echo "TIME: End: = `date +"%Y-%m-%d %T"`"
