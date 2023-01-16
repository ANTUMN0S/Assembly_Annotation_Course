#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=clustalo
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/ltr_retrotransposons/clustal_omega_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/ltr_retrotransposons/clustal_omega_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4
module load Phylogeny/FastTree/2.1.10

#get directories
input=/data/users/mberger/assembly_course/annotations/transposable_elements/ltr_retrotransposons

#align the sequences
clustalo -i ${input}/flye/gypsy_merge.fasta -o ${input}/flye/gypsy_protein.fasta
clustalo -i ${input}/flye/copia_merge.fasta -o ${input}/flye/copia_protein.fasta
clustalo -i ${input}/canu/gypsy_merge.fasta -o ${input}/canu/gypsy_protein.fasta
clustalo -i ${input}/canu/copia_merge.fasta -o ${input}/canu/copia_protein.fasta

#infer approximately-maximum-likelihood phylogenetic tree
FastTree -out ${input}/flye/gypsy.tree ${input}/flye/gypsy_protein.fasta
FastTree -out ${input}/flye/copia.tree ${input}/flye/copia_protein.fasta
FastTree -out ${input}/canu/gypsy.tree ${input}/canu/gypsy_protein.fasta
FastTree -out ${input}/canu/copia.tree ${input}/canu/copia_protein.fasta
