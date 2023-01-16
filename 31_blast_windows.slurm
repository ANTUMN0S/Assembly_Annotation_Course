#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=blast_windows
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/windows_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/windows_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load Blast/ncbi-blast/2.9.0+

#set directories
dir=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation

#change directory and make blast_db directory
cd ${dir}/flye
mkdir blast_db

makeblastdb -in contig_windows.fasta -dbtype nucl -out blast_db/contig_windows

blastn -query contig_windows.fasta -db blast_db/contig_windows -num_threads 10 -outfmt 6 -perc_identity 80 \
-max_hsps 1 > contig_windows.blastn

#change directory and make blast_db directory
cd ${dir}/canu
mkdir blast_db

makeblastdb -in contig_windows.fasta -dbtype nucl -out blast_db/contig_windows

blastn -query contig_windows.fasta -db blast_db/contig_windows -num_threads 10 -outfmt 6 -perc_identity 80 \
-max_hsps 1 > contig_windows.blastn
