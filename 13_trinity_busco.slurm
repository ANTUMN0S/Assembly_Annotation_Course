#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=02:010:00
#SBATCH --job-name=busco_Trinity
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/mberger/assembly_course/evaluations/output_trinity_busco_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/evaluations/error_trinity_busco_%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/mberger/assembly_course

# Use BUSCO with container
singularity exec \
--bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i ${WORKDIR}/assemblies/trinity/Trinity.fasta -l brassicales_odb10 -o initial_assembly --out_path ${WORKDIR}/evaluation/trinity/busco \
-m genome --cpu 4
