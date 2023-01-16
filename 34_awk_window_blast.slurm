#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=awk_blast
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/awk_blast_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/awk_blast_%j.e
#SBATCH --partition=pcourseassembly

#path to genome
in_dir=/data/users/mberger/assembly_course/polishing
out_dir=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation

#run akw
awk '$10 < $9 {print($2"\t"$10-1"\t"$9)}' ${out_dir}/flye/te_window.blastn > ${out_dir}/flye/te_window.bed 
awk '$10 > $9 {print($2"\t"$9-1"\t"$10)}' ${out_dir}/flye/te_window.blastn >> ${out_dir}/flye/te_window.bed
awk '$10 < $9 {print($2"\t"$10-1"\t"$9)}' ${out_dir}/canu/te_window.blastn > ${out_dir}/canu/te_window.bed 
awk '$10 > $9 {print($2"\t"$9-1"\t"$10)}' ${out_dir}/canu/te_window.blastn >> ${out_dir}/canu/te_window.bed
