#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=03:00:00
#SBATCH --job-name=genome_index
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/rna_2_genome/genome_index_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/rna_2_genome/genome_index_%j.e
#SBATCH --partition=pall

#load module
module add UHTS/Aligner/STAR/2.7.9a

#directory variables
input=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/rna_2_genome
genome=/data/users/mberger/assembly_course/polishing

#change directories
cd ${input}/canu
mkdir index
cd index 

#run STAR to generate genome index
STAR --runThreadN 4 --runMode genomeGenerate --genomeDir ${input}/canu/index --genomeFastaFiles ${genome}/canu/pilon.fasta --sjdbGTFfile ${input}/canu/converted.gtf

#change directories
cd ${input}/flye
mkdir genome_directory 
cd genome_directory 

#run STAR to generate genome index
STAR --runThreadN 4 --runMode genomeGenerate --genomeDir ${input}/flye/index --genomeFastaFiles ${genome}/flye/pilon.fasta --sjdbGTFfile ${input}/flye/converted.gtf

