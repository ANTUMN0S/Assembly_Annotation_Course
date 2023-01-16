#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=maker
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/maker_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/maker_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load SequenceAnalysis/GenePrediction/maker/2.31.9

#set directory variables
annotation=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation

#create control files
cd ${annotation}
maker -CTL