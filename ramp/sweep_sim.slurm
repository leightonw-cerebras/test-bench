#!/bin/bash

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-#-#-# SLURM Commands #-#-#-#-#

#SBATCH --job-name=sim_upsend                         # Job name
#SBATCH --mail-type=END,FAIL                       # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=leighton.wilson@cerebras.net   # Where to send mail

##SBATCH --nodelist=sdf-1
#SBATCH --cpus-per-task=28
#SBATCH --time=12:00:00

#SBATCH --output=sweep_sim_%j.log   # Standard output and error log
#SBATCH --error=sweep_sim_%j.log   # Standard output and error log

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-#-#-#-# Environment Set-up #-#-#-#-#

export SDK_INSTALL_PATH=~/cs_sdk-1.0.0/
export PATH=$SDK_INSTALL_PATH:$PATH

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-#-#-#-# Compile and Run #-#-#-#-#

python3 sweep.py --name out_sim

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
