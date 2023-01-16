#!/usr/bin/env bash
#
##SBATCH --cpus-per-task=2
##SBATCH --mem-per-cpu=4000M
##SBATCH --time=02:00:00
##SBATCH --job-name=fastqc
##SBATCH --mail-user=michael.berger1@students.unibe.ch
##SBATCH --mail-type=begin,fail,end
##SBATCH --output=/data/users/mberger/assembly_course/read_QC/fastqc/output_fastqc_%j.o
##SBATCH --error=/data/users/mberger/assembly_course/read_QC/fastqc/error_fastqc_%j.e
##SBATCH --partition=pcourseassembly

#load multiqc
module load UHTS/Analysis/MultiQC/1.8

#run multiqc
cd /data/users/mberger/assembly_course/read_QC/fastqc
multiqc .
