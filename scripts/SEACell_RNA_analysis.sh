#!/bin/bash
#SBATCH --partition=cpu-single
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=36:00:00
#SBATCH --mem=180gb
#SBATCH --job-name=SEACell_RNA
#SBATCH --output=SEACell_RNA_analysis.log
#SBATCH --error=SEACell_RNA_analysis.log

set -e

# Initialize conda for bash shell
source ${HOME}/miniforge3/etc/profile.d/conda.sh

# Activate enviroment
conda activate seacells 

# Run script
python -u SEACell_RNA_analysis.py

# Log off
echo "Job completed."

