#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=clustalw2
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/clustalw2_hs_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/clustalw2_hs_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load SequenceAnalysis/MultipleSequenceAlignment/clustalw2/2.1

#get the directories
in_dir=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation

#execute clustalw2 to align the TE sequences (you have to change directory, clustalw2 has an issue with using the ${} argument
cd ${in_dir}/flye
clustalw2 te_window.bed.fasta

cd ${in_dir}/canu
clustalw2 te_window.bed.fasta