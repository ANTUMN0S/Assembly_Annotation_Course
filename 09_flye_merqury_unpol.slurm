#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=merqury_flye_unpol
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/mberger/assembly_course/evaluations/output_flye_merqury_unpol_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/evaluations/error_flye_merqury_unpol_%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/mberger/assembly_course
DATADIR=/data/courses/assembly-annotation-course
read_dir=${WORKDIR}/participant_4/Illumina
meryl_dir=${WORKDIR}/evaluations/meryl

# Go to working directory for meryl
cd ${meryl_dir}/

# Count and combine the kmers from the forward and backward reads
singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
meryl union-sum \
output union.meryl \
[count k=21 ${read_dir}/ERR3624574_1.fastq.gz output read1.meryl] \
[count k=21 ${read_dir}/ERR3624574_2.fastq.gz output read2.meryl]

# Go to working directory for merqury
cd ${WORKDIR}/evaluation/flye/merqury

# Run container with merqury
singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
${meryl_dir}/union.meryl \
${WORKDIR}/assemblies/flye/assembly.fasta \
flye_unpol
