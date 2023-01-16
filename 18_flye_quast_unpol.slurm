#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=flye_quast_unpol_noref
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/mberger/assembly_course/evaluations/flye/quast/output_flye_quast_unpol_noref_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/evaluations/flye/quast/error_flye_quast_unpol_noref_%j.e
#SBATCH --partition=pcourseassembly

# Define paths
dir=/data/users/mberger/assembly_course

# Use QUAST with container once without and once with reference 
# Without reference:
singularity exec \
--bind $dir \
/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
quast.py ${dir}/assemblies/flye/assembly.fasta --eukaryote --large \
--est-ref-size 135000000 --threads 4 --labels flye_assembly_unpol \
-o ${dir}/evaluations/flye/quast

