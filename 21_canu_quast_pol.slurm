#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=00:30:00
#SBATCH --job-name=canu_quast_pol_w_ref
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/mberger/assembly_course/evaluations/output_quast_canu_pol_w_ref_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/evaluations/error_quast_canu_poli_w_ref_%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/mberger/assembly_course
DATADIR=/data/courses/assembly-annotation-course

# Use QUAST with container once without and once with reference
# Without reference:
#singularity exec \
#--bind $WORKDIR \
#/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
#quast.py ${WORKDIR}/polishing/canu/pilon.fasta --eukaryote --large \
#--est-ref-size 135000000 --threads 4 --labels canu_assembly_polished \
#-o ${WORKDIR}/evaluation/canu/quast/polished

# With reference:
singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
quast.py ${WORKDIR}/polishing/canu/pilon.fasta --eukaryote --large \
--est-ref-size 135000000 --threads 4 --labels canu_assembly_polished \
-r ${DATADIR}/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz \
-g ${DATADIR}/references/TAIR10_GFF3_genes.gff \
-o ${WORKDIR}/evaluations/canu/quast/polished_ref/
