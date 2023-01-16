#!/usr/bin/env bash

#SBATCH --cpus-per-task=15
#SBATCH --mem-per-cpu=16G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=maker
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/maker_exec_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/maker_exec_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load SequenceAnalysis/GenePrediction/maker/2.31.9

#set directory variables
canu=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/canu
flye=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/flye

#change directory and run master
cd ${canu}
maker

cd ${flye}
maker
