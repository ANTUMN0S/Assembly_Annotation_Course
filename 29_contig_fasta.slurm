#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:10:00
#SBATCH --job-name=get_length
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/contig_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/contig_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load UHTS/Analysis/SeqKit/0.13.2

#path to genome
in_dir=/data/users/mberger/assembly_course/polishing
out_dir=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation

#save the contigs in a new fasta file
seqkit grep -n -f ${out_dir}/flye/big_contig.txt ${in_dir}/flye/pilon.fasta -o ${out_dir}/flye/big_contig.fasta
seqkit grep -n -f ${out_dir}/canu/big_contig.txt ${in_dir}/canu/pilon.fasta -o ${out_dir}/canu/big_contig.fasta
