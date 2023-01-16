#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=prepare_duplications
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/prepare_duplication_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/prepare_duplication_%j.e
#SBATCH --partition=pall

#load module
module load UHTS/Analysis/SeqKit/0.13.2

#directory variables
input=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation
output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication

#save all -RA marked entries of gff and fasta as new files called Ath
grep -e "ID=LER_[0-9]*\-RA" ${input}/canu/putative.gff3 > ${output}/canu/Ath_1.gff
seqkit grep -n -r -p \-RA ${input}/canu/putative.fasta -o ${output}/canu/Ath.fasta


# Reformat gff file
# filter gff lines with mRNA position
grep -P "\tmRNA\t" ${output}/canu/Ath_1.gff > ${output}/canu/Ath_2.gff
# Shorten ID
sed 's/ID\=//' ${output}/canu/Ath_2.gff > ${output}/canu/Ath_3.gff
sed 's/\-RA\;.*/\-RA/' ${output}/canu/Ath_3.gff > ${output}/canu/Ath_4.gff
rm ${output}/canu/Ath_3.gff
# select columns 1,4,5,9 and rearrange them
awk -F'\t' -v OFS="\t" '{ print $1, $9, $4, $5}' ${output}/canu/Ath_4.gff > ${output}/canu/Ath.gff


#save all -RA marked entries of gff and fasta as new files called Ath
grep -e "ID=LER_[0-9]*\-RA" ${input}/flye/putative.gff3 > ${output}/flye/Ath_1.gff
seqkit grep -n -r -p \-RA ${input}/flye/putative.fasta -o ${output}/flye/Ath.fasta


# Reformat gff file
# filter gff lines with mRNA position
grep -P "\tmRNA\t" ${output}/flye/Ath_1.gff > ${output}/flye/Ath_2.gff
# Shorten ID
sed 's/ID\=//' ${output}/flye/Ath_2.gff > ${output}/flye/Ath_3.gff
sed 's/\-RA\;.*/\-RA/' ${output}/flye/Ath_3.gff > ${output}/flye/Ath_4.gff
rm ${output}/flye/Ath_3.gff
# select columns 1,4,5,9 and rearrange them
awk -F'\t' -v OFS="\t" '{ print $1, $9, $4, $5}' ${output}/flye/Ath_4.gff > ${output}/flye/Ath.gff



cd /data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication
# Create softlink to outgroup species
ln -s /data/courses/assembly-annotation-course/CDS_annotation/NNU_mRNA_single_model.gff NNU_mRNA_single_model.gff
ln -s /data/courses/assembly-annotation-course/CDS_annotation/NNU.pep.fa.ref.single_model NNU.pep.fa.ref.single_model
