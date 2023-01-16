#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=BUSCO
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,fail,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/busco_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/automatic_annotation/busco_%j.e

# Define paths to directories
WORKDIR=/data/users/mberger/assembly_course

# Go to working directory
cd $WORKDIR/annotations/protein_coding_sequences/automatic_annotation/canu

# Run BUSCO
singularity exec \
--bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $WORKDIR/annotations/protein_coding_sequences/automatic_annotation/canu/maker.fasta.all.maker.proteins.fasta -l brassicales_odb10 -o gene_annotation -m proteins -c 4 --out_path $WORKDIR/annotations/protein_coding_sequences/annotation_qc/busco/canu/ --download_path $WORKDIR/annotations/protein_coding_sequences/annotation_qc/busco/canu/

# Go to working directory
cd $WORKDIR/annotations/protein_coding_sequences/automatic_annotation/flye

# Run BUSCO
singularity exec \
--bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $WORKDIR/annotations/protein_coding_sequences/automatic_annotation/flye/maker.fasta.all.maker.proteins.fasta -l brassicales_odb10 -o gene_annotation -m proteins -c 4 --out_path $WORKDIR/annotations/protein_coding_sequences/annotation_qc/busco/flye/ --download_path $WORKDIR/annotations/protein_coding_sequences/annotation_qc/busco/flye/
