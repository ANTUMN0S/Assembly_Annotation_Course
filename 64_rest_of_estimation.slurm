#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=04:00:00
#SBATCH --job-name=rest_estimation
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/rest_estimation_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/rest_estimation_%j.e
#SBATCH --partition=pall

#load modules
module load Phylogeny/paml/4.9j
module add Emboss/EMBOSS/6.6.0

#directory variables
scripts=/data/courses/assembly-annotation-course/CDS_annotation/scripts
canu=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/canu/estimate_duplications
flye=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/flye/estimate_duplications


#split fasta files
cd ${canu}
${scripts}/split_flat ath_wgd_genes.fasta 
${scripts}/split_flat ath_wgd_genes.fasta.proteins

cd ${flye}
${scripts}/split_flat ath_wgd_genes.fasta 
${scripts}/split_flat ath_wgd_genes.fasta.proteins


#align proteins with bestflash
cd ${canu}
${scripts}/bestflash_from_list wgd_pairs.csv

cd ${flye}
${scripts}/bestflash_from_list wgd_pairs.csv


#generate codon-by-codon CDS alignment
cd ${canu}
${scripts}/pair_to_CDS_paml_pair LER pair

cd ${flye}
${scripts}/pair_to_CDS_paml_pair LER pair


#calculate KA/KS values for all WGD pair alignments
cd ${canu}
${scripts}/PAML_yn00_from_CDS_pair LER > PAML_yn00_results

cd ${flye}
${scripts}/PAML_yn00_from_CDS_pair LER > PAML_yn00_results