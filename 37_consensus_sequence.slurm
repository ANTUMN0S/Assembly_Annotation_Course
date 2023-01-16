#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=cons_seq
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/cons_hs_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/cons_hs_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load Emboss/EMBOSS/6.6.0

#get the directories
in_dir=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation

#get consensus sequence
cons -sequence ${in_dir}/canu/te_element.fasta -outseq ${in_dir}/canu/te_element.cons -name te_element_cons
#cons -sequence ${in_dir}/flye/te_element.fasta -outseq ${in_dir}/flye/te_element.cons -name te_element_cons
