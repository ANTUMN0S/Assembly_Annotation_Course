#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00
#SBATCH --job-name=contig_window
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/windows_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/windows_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load UHTS/Analysis/SeqKit/0.13.2

#path to genome
dir=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation

#split the contigs into 500bp windows
seqkit sliding -s 500 -W 500 -g ${dir}/flye/big_contig.fasta > ${dir}/flye/contig_windows.fasta
seqkit sliding -s 500 -W 500 -g ${dir}/canu/big_contig.fasta > ${dir}/canu/contig_windows.fasta