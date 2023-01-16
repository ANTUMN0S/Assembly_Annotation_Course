#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8G
#SBATCH --time=6:00:00
#SBATCH --job-name=busco_plots
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/evaluations/compare/busco/busco_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/evaluations/compare//busco/busco_%j.e
#SBATCH --partition=pall

WORKDIR=/data/users/mberger/assembly_course
OUTDIR=/data/users/mberger/assembly_course/evaluations/compare/busco

cd ${OUTDIR}

singularity exec --bind ${OUTDIR} /data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif ${OUTDIR}/generate_plot.py -wd ${OUTDIR}/BUSCO_summaries
