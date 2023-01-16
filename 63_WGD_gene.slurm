#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=04:00:00
#SBATCH --job-name=wdg_gene
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/wdg_gene_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/wdg_gene_%j.e
#SBATCH --partition=pall

#load modules
module load UHTS/Analysis/SeqKit/0.13.2

#directory variables
canu=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/canu
flye=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/flye
canu_trans=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/canu
flye_trans=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/flye


#create fastas with CDS and protein sequences of the WDG genes
cut -f 1 ${canu}/DupGen_output/Ath.wgd.genes > ${canu}/ID.txt 
seqkit grep -f ${canu}/ID.txt ${canu_trans}/maker.fasta.all.maker.transcripts.fasta -o ${canu}/ath_wdg_genes.fasta
seqkit translate ${canu}/ath_wdg_genes.fasta -o ${canu}/ath_wdg_genes.fasta.proteins
sed -i 's/_frame=1/_p/' ${canu}/ath_wdg_genes.fasta.proteins 

cut -f 1 ${flye}/DupGen_output/Ath.wgd.genes > ${flye}/ID.txt 
seqkit grep -f ${flye}/ID.txt ${flye_trans}/maker.fasta.all.maker.transcripts.fasta -o ${flye}/ath_wdg_genes.fasta
seqkit translate ${flye}/ath_wdg_genes.fasta -o ${flye}/ath_wdg_genes.fasta.proteins
sed -i 's/_frame=1/_p/' ${flye}/ath_wdg_genes.fasta.proteins 


# create wdg pair list
cut -f 1,3 ${canu}/DupGen_output/Ath.wgd.pairs > ${canu}/wgd_pairs.csv 
sed -i 's/RA/RA_p/g' ${canu}/wgd_pairs.csv

cut -f 1,3 ${flye}/DupGen_output/Ath.wgd.pairs > ${flye}/wgd_pairs.csv 
sed -i 's/RA/RA_p/g' ${flye}/wgd_pairs.csv