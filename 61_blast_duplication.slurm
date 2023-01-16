#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=04:00:00
#SBATCH --job-name=blast_duplication
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/blast_duplication_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/blast_duplication_%j.e
#SBATCH --partition=pall

#load module
module load Blast/ncbi-blast/2.10.1+

#directory variables
input=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication

#db of the Ath and the Nu file
cd ${input}

mkdir blast_db
makeblastdb -in ${input}/canu/Ath.fasta -dbtype prot -out ${input}/blast_db/canu
makeblastdb -in ${input}/flye/Ath.fasta -dbtype prot -out ${input}/blast_db/flye
makeblastdb -in ${input}/NNU.pep.fa.ref.single_model -dbtype prot -out ${input}/blast_db/nnu

#blast them bitches
blastp -query ${input}/canu/Ath.fasta -db ${input}/blast_db/canu -evalue 1e-10 -max_target_seqs 5 -outfmt 6 -num_threads 10 > ${input}/canu/Ath.blast
blastp -query ${input}/flye/Ath.fasta -db ${input}/blast_db/flye -evalue 1e-10 -max_target_seqs 5 -outfmt 6 -num_threads 10 > ${input}/flye/Ath.blast
blastp -query ${input}/canu/Ath.fasta -db ${input}/blast_db/nnu -evalue 1e-10 -max_target_seqs 5 -outfmt 6 -num_threads 10 > ${input}/canu/Ath_Nnu.blast
blastp -query ${input}/flye/Ath.fasta -db ${input}/blast_db/nnu -evalue 1e-10 -max_target_seqs 5 -outfmt 6 -num_threads 10 > ${input}/flye/Ath_Nnu.blast




