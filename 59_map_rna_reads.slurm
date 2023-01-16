#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=2-00:00:00
#SBATCH --job-name=map_rna_2_genome
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/rna_2_genome/map_rna_2_genome_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/rna_2_genome/map_rna_2_genome_%j.e
#SBATCH --partition=pall

#load module
module add UHTS/Aligner/STAR/2.7.9a

#directory variables
input=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/rna_2_genome
rna=/data/users/mberger/assembly_course/participant_4/RNAseq

STAR --runThreadN 4 --genomeDir ${input}/canu/index --readFilesIn <(zcat ${rna}/SRR1734309_1.fastq.gz) <(zcat ${rna}/SRR1734309_2.fastq.gz) --outFileNamePrefix ${input}/canu/star_ \
--outSAMtype BAM SortedByCoordinate --outFilterMultimapNmax 10 read --outFilterMismatchNoverLmax 0.01 --alignIntronMax 60000

STAR --runThreadN 4 --genomeDir ${input}/flye/index --readFilesIn <(zcat ${rna}/SRR1734309_1.fastq.gz) <(zcat ${rna}/SRR1734309_2.fastq.gz) --outFileNamePrefix ${input}/flye/star_ \
--outSAMtype BAM SortedByCoordinate --outFilterMultimapNmax 10 read --outFilterMismatchNoverLmax 0.01 --alignIntronMax 60000
