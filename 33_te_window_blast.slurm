#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=te_blast
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/te_blast_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/te_blast_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load Blast/ncbi-blast/2.9.0+
module load UHTS/Analysis/SeqKit/0.13.2

#first get a fasta file with only the te window you've chosen (window 43 for canu, 10 for flye)
#path to genome
in_dir=/data/users/mberger/assembly_course/polishing
out_dir=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation

#save the contigs in a new fasta file
seqkit grep -n -f ${out_dir}/flye/te_window.txt ${out_dir}/flye/contig_windows.fasta -o ${out_dir}/flye/te_window.fasta
seqkit grep -n -f ${out_dir}/canu/te_window.txt ${out_dir}/canu/contig_windows.fasta -o ${out_dir}/canu/te_window.fasta

#create genome db
makeblastdb -in ${in_dir}/flye/pilon.fasta -dbtype nucl -out ${out_dir}/flye/blast_db/genome
makeblastdb -in ${in_dir}/canu/pilon.fasta -dbtype nucl -out ${out_dir}/canu/blast_db/genome

#blast this bitch
blastn -query ${out_dir}/flye/te_window.fasta -db ${out_dir}/flye/blast_db/genome -outfmt 6 -num_threads 10 -perc_identity 80 -qcov_hsp_perc 80 -max_hsps 1 > ${out_dir}/flye/te_window.blastn
blastn -query ${out_dir}/canu/te_window.fasta -db ${out_dir}/canu/blast_db/genome -outfmt 6 -num_threads 10 -perc_identity 80 -qcov_hsp_perc 80 -max_hsps 1 > ${out_dir}/canu/te_window.blastn
