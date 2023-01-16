#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=replace_id
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/replace_id_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/replace_id_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load SequenceAnalysis/GenePrediction/maker/2.31.9

#set directory variables
input=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation

#build shorter IDs for genes and transcripts
maker_map_ids --prefix LER_ ${input}/canu/maker.gff3 > ${input}/canu/maker.map
maker_map_ids --prefix LER_ ${input}/flye/maker.gff3 > ${input}/flye/maker.map

#map short IDs to fasta and gff files
map_fasta_ids ${input}/canu/maker.map ${input}/canu/maker.fasta.all.maker.proteins.fasta
map_fasta_ids ${input}/canu/maker.map ${input}/canu/maker.fasta.all.maker.transcripts.fasta
map_gff_ids ${input}/canu/maker.map ${input}/canu/maker.gff3

map_fasta_ids ${input}/flye/maker.map ${input}/flye/maker.fasta.all.maker.proteins.fasta
map_fasta_ids ${input}/flye/maker.map ${input}/flye/maker.fasta.all.maker.transcripts.fasta
map_gff_ids ${input}/flye/maker.map ${input}/flye/maker.gff3
