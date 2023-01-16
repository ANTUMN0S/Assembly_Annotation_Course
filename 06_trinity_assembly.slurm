#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=12
#SBATCH --partition=pall
#SBATCH --job-name=trinity_assembly
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mberger/assembly_course/assemblies/flye/output_trinity_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/assemblies/flye/error_trinity_%j.e

#set input and output directory variables
input_dir=/data/users/mberger/assembly_course/participant_4/RNAseq
output_dir=/data/users/mberger/assembly_course/assemblies/trinity

#load the module
module load UHTS/Assembler/trinityrnaseq/2.5.1

#run trinity
Trinity --seqType fq --left ${input_dir}/SRR1734309_1.fastq.gz \
--right ${input_dir}/SRR1734309_2.fastq.gz \
--CPU 12 --max_memory 48G --output ${output_dir}
