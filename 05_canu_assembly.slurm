#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=1
#SBATCH --partition=pcourseassembly
#SBATCH --job-name=canu_assembly
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mberger/assembly_course/assemblies/canu/output_canu_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/assemblies/canu/error_canu_%j.e

#set input and output directory variables
input_dir=/data/users/mberger/assembly_course/participant_4/pacbio
output_dir=/data/users/mberger/assembly_course/assemblies/canu

#load the module
module load UHTS/Assembler/canu/2.1.1

#run canu
canu -p arabidopsis -d ${output_dir} genomeSize=130m \
maxThreads=16 \
maxMemory=64 \
gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" \
gridOptions="--partition=pcourseassembly --mail-user=michael.berger1@students.unibe.ch \
--mail-type=fail,end \
--output=/data/users/mberger/assembly_course/assemblies/canu/output_canu_%j.o \
--error=/data/users/mberger/assembly_course/assemblies/canu/error_canu_%j.e" \
-pacbio ${input_dir}/*
