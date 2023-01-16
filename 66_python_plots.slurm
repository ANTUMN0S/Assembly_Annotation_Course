#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=04:00:00
#SBATCH --job-name=average_ks
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/average_ks_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/average_ks_%j.e
#SBATCH --partition=pall

#directory variables
scripts=/data/courses/assembly-annotation-course/CDS_annotation/scripts
canu=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/canu/estimate_duplications
flye=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/flye/estimate_duplications


#the things below work in theory, but for some reason only if you do it as a srun job, so step by step

#initialize conda
conda init bash
#conda create -y -n py27 python=2.7
conda activate py27
#pip install pandas
#pip install scikit-learn
#pip install matplotlib

cd ${canu}
python ${scripts}/plot_syntenic_blocks_ks_distri.py LER.synteny.blocks.ks.info 2 LER

cd ${flye}	
python ${scripts}/plot_syntenic_blocks_ks_distri.py \
    LER.synteny.blocks.ks.info \
    2 \
    LER


