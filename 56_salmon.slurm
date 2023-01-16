#!/usr/bin/env bash

#SBATCH --time=2-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=salmon
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/annotation_qc/salmon_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/annotation_qc/salmon_%j.e
#SBATCH --partition=pcourseassembly

# Define paths to directories
DATADIR=/data/users/mberger/assembly_course
CONTAINER=/software/singularity/containers

# Go to working directory
cd $DATADIR/annotations/protein_coding_sequences/annotation_qc/salmon/canu

singularity exec \
--bind $DATADIR \
--bind $CONTAINER \
$CONTAINER/salmon-1.7.0-1.ubuntu18.sif \
salmon index -t $DATADIR/annotations/protein_coding_sequences/automatic_annotation/canu/maker.fasta.all.maker.transcripts.fasta -i transcripts_index -k 31

# Define paths to directories
WORKDIR=/data/users/mberger/assembly_course
DATADIR=/data/courses/assembly-annotation-course/raw_data/Ler/participant_4/RNAseq
CONTAINER=/software/singularity/containers

singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
--bind $CONTAINER \
$CONTAINER/salmon-1.7.0-1.ubuntu18.sif \
salmon quant -i transcripts_index -l A -1 <(zcat $DATADIR/SRR1734309_1.fastq.gz) -2 <(zcat $DATADIR/SRR1734309_2.fastq.gz) --validateMappings -o transcripts_quant



# Define paths to directories
DATADIR=/data/users/mberger/assembly_course
CONTAINER=/software/singularity/containers

# Go to working directory
cd $WORKDIR/annotations/protein_coding_sequences/annotation_qc/salmon/flye

singularity exec \
--bind $DATADIR \
--bind $CONTAINER \
$CONTAINER/salmon-1.7.0-1.ubuntu18.sif \
salmon index -t $DATADIR/annotations/protein_coding_sequences/automatic_annotation/flye/maker.fasta.all.maker.transcripts.fasta -i transcripts_index -k 31

# Define paths to directories
WORKDIR=/data/users/mberger/assembly_course
DATADIR=/data/courses/assembly-annotation-course/raw_data/Ler/participant_4/RNAseq
CONTAINER=/software/singularity/containers

singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
--bind $CONTAINER \
$CONTAINER/salmon-1.7.0-1.ubuntu18.sif \
salmon quant -i transcripts_index -l A -1 <(zcat $DATADIR/SRR1734309_1.fastq.gz) -2 <(zcat $DATADIR/SRR1734309_2.fastq.gz) --validateMappings -o transcripts_quant
