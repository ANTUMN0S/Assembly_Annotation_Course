#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=03:00:00
#SBATCH --job-name=merqury_flye_polished
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/mberger/assembly_course/evaluations/output_merqury_flye_pol_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/evaluations/error_merqury_flye_pol_%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/mberger/assembly_course
meryl_dir=${WORKDIR}/evaluations/meryl

# Go to working directory for merqury
cd ${WORKDIR}/evaluations/flye/merqury

# Run container with merqury
singularity exec \
--bind $WORKDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
${meryl_dir}/union.meryl \
${WORKDIR}/polishing/flye/pilon.fasta \
flye_polished
