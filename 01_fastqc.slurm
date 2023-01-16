#!/usr/bin/env bash

#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=02:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mberger/assembly_course/read_QC/fastqc/output_fastqc_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/read_QC/fastqc/error_fastqc_%j.e
#SBATCH --partition=pcourseassembly

#load the module
module add UHTS/Quality_control/fastqc/0.11.9

#set the directories
input_dir=/data/users/mberger/assembly_course/participant_4
output_dir=/data/users/mberger/assembly_course/read_QC/fastqc 

#fastqc output will be put into a seperate directory
fastqc -o ${output_dir}/Illumina ${input_dir}/Illumina/*.fastq.gz

fastqc -o ${output_dir}/pacbio ${input_dir}/pacbio/*.fastq.gz

fastqc -o ${output_dir}/RNAseq ${input_dir}/RNAseq/*.fastq.gz



