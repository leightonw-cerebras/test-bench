#!/bin/bash

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-#-#-# SLURM Commands #-#-#-#-#

#SBATCH --job-name=cs2_upsend                         # Job name
#SBATCH --mail-type=END,FAIL                       # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=leighton.wilson@cerebras.net   # Where to send mail

#SBATCH --gres=cs:cerebras:1
##SBATCH --nodelist=sdf-1
#SBATCH --cpus-per-task=28
#SBATCH --time=12:00:00

#SBATCH --output=sweep_cs2_%j.log   # Standard output and error log
#SBATCH --error=sweep_cs2_%j.log   # Standard output and error log

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-#-#-#-# Environment Set-up #-#-#-#-#

export SDK_INSTALL_PATH=~/cs_sdk-1.0.0/
export PATH=$SDK_INSTALL_PATH:$PATH

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-#-#-#-# Compile and Run #-#-#-#-#

python3 sweep.py --cmaddr $CS_IP_ADDR:9000 --name out_cs2

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
