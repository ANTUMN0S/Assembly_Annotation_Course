#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=02:00:00
#SBATCH --job-name=BUSCO_flye_polished
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/mberger/assembly_course/evaluations/output_busco_pol%j.o
#SBATCH --error=/data/users/mberger/assembly_course/evaluations/error_busco_pol%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/mberger/assembly_course

# Use BUSCO with container
singularity exec \
--bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i ${WORKDIR}/polishing/flye/pilon.fasta -l brassicales_odb10 -o polished_assembly --out_path ${WORKDIR}/evaluations/flye/busco \
-m genome --cpu 4
