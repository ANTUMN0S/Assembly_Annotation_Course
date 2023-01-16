#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=TEsorter_ref
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/TEsorter_ref_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/TEsorter_ref_%j.e
#SBATCH --partition=pcourseassembly

# Define paths to directories
CONTAINER=/data/courses/assembly-annotation-course
WORKDIR=/data/users/mberger/assembly_course/annotations/transposable_elements/edta

# Go to working directory
cd $WORKDIR/

# Run EDTA for polished canu assembly
singularity exec \
--bind $CONTAINER \
--bind $WORKDIR \
$CONTAINER/containers2/TEsorter_1.3.0.sif \
TEsorter $CONTAINER/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta -db rexdb-plant