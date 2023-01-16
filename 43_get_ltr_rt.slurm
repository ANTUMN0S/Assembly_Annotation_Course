#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=ltr_rt
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/ltr_retrotransposons/ltr_rt_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/ltr_retrotransposons/ltr_rt_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load UHTS/Analysis/SeqKit/0.13.2

#get directories
input=/data/users/mberger/assembly_course/annotations/transposable_elements/edta
output=/data/users/mberger/assembly_course/annotations/transposable_elements/ltr_retrotransposons

#get copia elements, get gypsy elements
more ${input}/flye/gff_simplified.fasta.rexdb-plant.cls.pep|grep Ty1-RT|sed 's/>//'|sed 's/ .\+//' > ${output}/flye/copia_id.txt
more ${input}/flye/gff_simplified.fasta.rexdb-plant.cls.pep|grep Ty3-RT|sed 's/>//'|sed 's/ .\+//' > ${output}/flye/gypsy_id.txt
more ${input}/canu/gff_simplified.fasta.rexdb-plant.cls.pep|grep Ty1-RT|sed 's/>//'|sed 's/ .\+//' > ${output}/canu/copia_id.txt
more ${input}/canu/gff_simplified.fasta.rexdb-plant.cls.pep|grep Ty1-RT|sed 's/>//'|sed 's/ .\+//' > ${output}/canu/gypsy_id.txt
more ${input}/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.cls.pep|grep Ty1-RT|sed 's/>//'|sed 's/ .\+//' > ${output}/copia_id.txt
more ${input}/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.cls.pep|grep Ty1-RT|sed 's/>//'|sed 's/ .\+//' > ${output}/gypsy_id.txt

#run seqkit to get the fasta files
seqkit grep -f ${output}/flye/copia_id.txt ${input}/flye/gff_simplified.fasta.rexdb-plant.cls.pep -o ${output}/flye/copia.fasta
seqkit grep -f ${output}/flye/gypsy_id.txt ${input}/flye/gff_simplified.fasta.rexdb-plant.cls.pep -o ${output}/flye/gypsy.fasta
seqkit grep -f ${output}/canu/copia_id.txt ${input}/canu/gff_simplified.fasta.rexdb-plant.cls.pep -o ${output}/canu/copia.fasta
seqkit grep -f ${output}/canu/gypsy_id.txt ${input}/canu/gff_simplified.fasta.rexdb-plant.cls.pep -o ${output}/canu/gypsy.fasta
seqkit grep -f ${output}/copia_id.txt ${input}/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.cls.pep -o ${output}/copia.fasta
seqkit grep -f ${output}/gypsy_id.txt ${input}/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.cls.pep -o ${output}/gypsy.fasta

#concatenate arabidopsis and brassicaceae
cat ${output}/copia.fasta ${output}/flye/copia.fasta > ${output}/flye/copia_merge.fasta
cat ${output}/gypsy.fasta ${output}/flye/gypsy.fasta > ${output}/flye/gypsy_merge.fasta
cat ${output}/copia.fasta ${output}/canu/copia.fasta > ${output}/canu/copia_merge.fasta
cat ${output}/gypsy.fasta ${output}/canu/gypsy.fasta > ${output}/canu/gypsy_merge.fasta

#shorten the identifiers
sed -i 's/#.\+//' ${output}/flye/copia_merge.fasta
sed -i 's/:/_/' ${output}/flye/copia_merge.fasta
sed -i 's/#.\+//' ${output}/canu/copia_merge.fasta
sed -i 's/:/_/' ${output}/canu/copia_merge.fasta


