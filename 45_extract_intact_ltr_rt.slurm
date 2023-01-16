#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=dating
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/dating/date_prep_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/dating/date_prep_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load UHTS/Analysis/BEDTools/2.29.2

#set directory variables
input=/data/users/mberger/assembly_course/annotations/transposable_elements/edta
output=/data/users/mberger/assembly_course/annotations/transposable_elements/dating
genome=/data/users/mberger/assembly_course/polishing

#create GFF with only LTR retrotransposons
awk '$3~/retrotransposon/' ${input}/flye/pilon.fasta.mod.EDTA.intact.gff3 > ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR
awk '$3~/retrotransposon/' ${input}/canu/pilon.fasta.mod.EDTA.intact.gff3 > ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR

#simplify TE identifiers and swap columns 3 and 9
sed 's/\;Classification.*//' ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR > ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_classification
sed 's/\;Classification.*//' ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR > ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_classification
sed 's/ID.*Name\=//' ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_classification > ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_name
sed 's/ID.*Name\=//' ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_classification > ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_name
awk -F'\t' -v OFS="\t" '{print $1, $2, $9, $4, $5, $6, $7, $8, $3}' ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_name > ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_rearranged
awk -F'\t' -v OFS="\t" '{print $1, $2, $9, $4, $5, $6, $7, $8, $3}' ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_name > ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_rearranged
sed 's/\_pi.*\tEDTA/\_pilon\tEDTA/' ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_rearranged > ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_fixed
sed 's/\_pi.*\tEDTA/\_pilon\tEDTA/' ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_rearranged > ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_fixed


#reformat GFF
sed -i 's/ID.\+Name=//' ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_fixed
sed -i 's/ID.\+Name=//' ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_fixed
sed -i 's/;.\+//' ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_fixed
sed -i 's/;.\+//' ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_fixed
awk '{print($1,$2,$9,$4,$5,$6,$7,$8,$3)}' ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_fixed |sed 's/ /\t/g' > ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_ref
awk '{print($1,$2,$9,$4,$5,$6,$7,$8,$3)}' ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_fixed |sed 's/ /\t/g' > ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_ref

#extract the sequences
bedtools getfasta -fi ${genome}/flye/pilon.fasta -bed ${output}/flye/pilon.mod.EDTA.intact.gff3_LTR_ref -name > ${output}/flye/dating.fasta
bedtools getfasta -fi ${genome}/canu/pilon.fasta -bed ${output}/canu/pilon.mod.EDTA.intact.gff3_LTR_ref -name > ${output}/canu/dating.fasta

#rename LTR retrotransposons
sed -i 's/:/_/' ${output}/flye/dating.fasta
sed -i 's/:/_/' ${output}/canu/dating.fasta
sed -i 's/>/>Ler_/' ${output}/flye/dating.fasta
sed -i 's/>/>Ler_/' ${output}/canu/dating.fasta
