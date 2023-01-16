#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=03:00:00
#SBATCH --job-name=gff_2_gtf
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/rna_2_genome/convert_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/rna_2_genome/convert_%j.e
#SBATCH --partition=pall

#load module
module load UHTS/Assembler/cufflinks/2.2.1

#directries
input=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation
output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/rna_2_genome

#convert
gffread ${input}/flye/putative.gff3 -T -o ${output}/flye/converted.gtf
gffread ${input}/canu/putative.gff3 -T -o ${output}/canu/converted.gtf