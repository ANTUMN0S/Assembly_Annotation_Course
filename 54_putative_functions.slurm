#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=6G
#SBATCH --time=03:00:00
#SBATCH --job-name=putative_functions
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/putative_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/putative_%j.e
#SBATCH --partition=pall

#load module
module load SequenceAnalysis/GenePrediction/maker/2.31.9
module load Blast/ncbi-blast/2.9.0+

#set directory variables
input=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation
reference=/data/courses/assembly-annotation-course/CDS_annotation

#make blast db
#mkdir ${input}/blast_db
#makeblastdb -in ${reference}/uniprot-plant_reviewed.fasta -dbtype prot -out ${input}/blast_db/proteins

#Blastp the predicted proteins against the uniport database
#blastp -query ${input}/canu/maker.fasta.all.maker.proteins.fasta -db ${input}/blast_db/proteins -num_threads 10 -outfmt 6 -evalue 1e-10 > ${input}/canu/blastp_out
#blastp -query ${input}/flye/maker.fasta.all.maker.proteins.fasta -db ${input}/blast_db/proteins -num_threads 10 -outfmt 6 -evalue 1e-10 > ${input}/flye/blastp_out

#map putative functions to the gff3 and fasta file
maker_functional_fasta ${reference}/uniprot-plant_reviewed.fasta ${input}/canu/blastp_out ${input}/canu/maker.fasta.all.maker.proteins.fasta > ${input}/canu/putative.fasta
maker_functional_gff ${reference}/uniprot-plant_reviewed.fasta ${input}/canu/blastp_out ${input}/canu/maker.gff3 > ${input}/canu/putative.gff3
maker_functional_fasta ${reference}/uniprot-plant_reviewed.fasta ${input}/flye/blastp_out ${input}/flye/maker.fasta.all.maker.proteins.fasta > ${input}/flye/putative.fasta
maker_functional_gff ${reference}/uniprot-plant_reviewed.fasta ${input}/flye/blastp_out ${input}/flye/maker.gff3 > ${input}/flye/putative.gff3