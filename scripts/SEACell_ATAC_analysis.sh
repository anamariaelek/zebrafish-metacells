#!/bin/bash
#SBATCH --partition=cpu-single
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=400gb
#SBATCH --job-name=SEACell_ATAC
#SBATCH --output=SEACell_ATAC_analysis.log
#SBATCH --error=SEACell_ATAC_analysis.log

set -e

# Initialize conda for bash shell
source ${HOME}/miniforge3/etc/profile.d/conda.sh

# Activate enviroment
conda activate seacells 

# Run script
python -u SEACell_ATAC_analysis.py

# Log off
echo "Job completed."

