#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=TEsorter
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/TEsorter_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/TEsorter_%j.e
#SBATCH --partition=pcourseassembly

# Define paths to directories
CONTAINER=/data/courses/assembly-annotation-course
WORKDIR=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/canu

# Go to working directory
cd $WORKDIR/

# Run EDTA for polished canu assembly
singularity exec \
--bind $CONTAINER \
--bind $WORKDIR \
$CONTAINER/containers2/TEsorter_1.3.0.sif \
TEsorter gff_simplified.fasta -db rexdb-plant

# change directory
WORKDIR=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/flye

# Go to working directory
cd $WORKDIR/

# Run EDTA for polished flye assembly
singularity exec \
--bind $CONTAINER \
--bind $WORKDIR \
$CONTAINER/containers2/TEsorter_1.3.0.sif \
TEsorter gff_simplified.fasta -db rexdb-plant
