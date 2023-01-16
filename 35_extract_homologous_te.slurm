#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=te_blast
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/extract_hs_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/extract_hs_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load UHTS/Analysis/SeqKit/0.13.2

#get directories
genome=/data/users/mberger/assembly_course/polishing
in_dir=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation

# extract homolugous TE sequences, including flanking regions
seqkit subseq --bed ${in_dir}/flye/te_window.bed ${genome}/flye/pilon.fasta -u 2000 -d 2000 > ${in_dir}/flye/te_window.bed.fasta
seqkit subseq --bed ${in_dir}/canu/te_window.bed ${genome}/canu/pilon.fasta -u 2000 -d 2000 > ${in_dir}/canu/te_window.bed.fasta
