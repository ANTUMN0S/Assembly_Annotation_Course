#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=8G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=edta_canu
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/canu_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/canu_%j.e
#SBATCH --partition=pcourseassembly

#change the directory
/data/users/mberger/assembly_course/annotations/transposable_elements/edta/canu

#set path to directories
CONTAINER=/data/courses/assembly-annotation-course/containers2 
WORKDIR=/data/users/mberger/assembly_course

#call singularity
singularity exec \
--bind $CONTAINER \
--bind $WORKDIR \
$CONTAINER/EDTA_v1.9.6.sif \
EDTA.pl \
--genome $WORKDIR/polishing/canu/pilon.fasta \
--species others \
--step all \
--cds $WORKDIR/annotations/transposable_elements/edta/TAIR10_cds_20110103_representative_gene_model \
--anno 1 \
--threads 16

