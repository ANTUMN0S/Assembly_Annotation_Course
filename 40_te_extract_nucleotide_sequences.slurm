#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=te_extract_ns
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/te_extract_ns_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/te_extract_ns_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load UHTS/Analysis/BEDTools/2.29.2

#set directories
in_dir=/data/users/mberger/assembly_course/annotations/transposable_elements/edta

#change directory
cd ${in_dir}/canu

#get rid of gff lines that do not describe the entire TE
awk '$3~/retrotransposon/' pilon.fasta.mod.EDTA.TEanno.gff3 > pilon.fasta.mod.EDTA.TEanno.gff3_edited

#add remaining DNA transposons to new gff
grep -v LTR pilon.fasta.mod.EDTA.TEanno.gff3 >> pilon.fasta.mod.EDTA.TEanno.gff3_edited

#simplify TE identifiers and swap columns 3 and 9
sed 's/\;Classification.*//' pilon.fasta.mod.EDTA.TEanno.gff3_edited > pilon.fasta.mod.EDTA.gff3_classification
sed 's/ID.*Name\=//' pilon.fasta.mod.EDTA.gff3_classification > pilon.fasta.mod.EDTA.gff3_name
awk -F'\t' -v OFS="\t" '{print $1, $2, $9, $4, $5, $6, $7, $8, $3}' pilon.fasta.mod.EDTA.gff3_name > pilon.fasta.mod.EDTA.gff3_rearranged
sed 's/\_pi.*\tEDTA/\_pilon\tEDTA/' pilon.fasta.mod.EDTA.gff3_rearranged > pilon.fasta.mod.EDTA.gff3_fixed

#extract the TE sequences from the genome assembly with bedtools
bedtools getfasta -name -fi pilon.fasta -bed pilon.fasta.mod.EDTA.gff3_fixed -fo gff_simplified.fasta

sed -i 's/:/_/g' gff_simplified.fasta



#change directory
cd ${in_dir}/flye

#get rid of gff lines that do not describe the entire TE
awk '$3~/retrotransposon/' pilon.fasta.mod.EDTA.TEanno.gff3 > pilon.fasta.mod.EDTA.TEanno.gff3_edited

#add remaining DNA transposons to new gff
grep -v LTR pilon.fasta.mod.EDTA.TEanno.gff3 >> pilon.fasta.mod.EDTA.TEanno.gff3_edited

#simplify TE identifiers and swap columns 3 and 9
sed 's/\;Classification.*//' pilon.fasta.mod.EDTA.TEanno.gff3_edited > pilon.fasta.mod.EDTA.gff3_classification
sed 's/ID.*Name\=//' pilon.fasta.mod.EDTA.gff3_classification > pilon.fasta.mod.EDTA.gff3_name
awk -F'\t' -v OFS="\t" '{print $1, $2, $9, $4, $5, $6, $7, $8, $3}' pilon.fasta.mod.EDTA.gff3_name > pilon.fasta.mod.EDTA.gff3_rearranged
sed 's/\_pi.*\tEDTA/\_pilon\tEDTA/' pilon.fasta.mod.EDTA.gff3_rearranged > pilon.fasta.mod.EDTA.gff3_fixed


#extract the TE sequences from the genome assembly with bedtools
bedtools getfasta -name -fi pilon.fasta -bed pilon.fasta.mod.EDTA.gff3_fixed -fo gff_simplified.fasta

sed -i 's/:/_/g' gff_simplified.fasta

