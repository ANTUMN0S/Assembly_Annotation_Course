#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=blast_library
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/library_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation/library_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load Blast/ncbi-blast/2.9.0+

#set directories
in_dir=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation
library=/data/courses/assembly-annotation-course/CDS_annotation

#create db for library
cd ${in_dir}
mkdir blast_db

makeblastdb -in ${library}/Brassicaceae_repbase_all_march2019.fasta -dbtype nucl -out ${in_dir}/blast_db/library

#blast the consensus sequence against the library
blastn -query ${in_dir}/canu/te_element.fasta -db ${in_dir}/blast_db/library -outfmt 6 -num_threads 10 -max_hsps 1 > ${in_dir}/canu/te_element.blastn
#blastn -query ${in_dir}/flye/te_element.fasta -db ${in_dir}/blast_db/library -outfmt 6 -num_threads 10 -max_hsps 1 > ${in_dir}/flye/te_element.blastn


