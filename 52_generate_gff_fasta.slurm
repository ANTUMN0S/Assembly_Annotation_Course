#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=gff_fasta
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/gff_fasta_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/gff_fasta_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load SequenceAnalysis/GenePrediction/maker/2.31.9

#set directory variables
input=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation

#generate gff and fasta files
gff3_merge -d ${input}/canu/pilon.maker.output/pilon_master_datastore_index.log -o ${input}/canu/maker.gff3
gff3_merge -d ${input}/flye/pilon.maker.output/pilon_master_datastore_index.log -o ${input}/flye/maker.gff3
fasta_merge -d ${input}/canu/pilon.maker.output/pilon_master_datastore_index.log -o ${input}/canu/maker.fasta
fasta_merge -d ${input}/flye/pilon.maker.output/pilon_master_datastore_index.log -o ${input}/flye/maker.fasta

