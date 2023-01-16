#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=blast_edta_te
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/blast_edta_te_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/transposable_elements/edta/blast_edta_te_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load Blast/ncbi-blast/2.9.0+

#set directories
in_dir=/data/users/mberger/assembly_course/annotations/transposable_elements/edta
te=/data/users/mberger/assembly_course/annotations/transposable_elements/manual_annotation

#create db for library
cd ${in_dir}/canu
mkdir blast_db

cd ${in_dir}/flye
mkdir blast_db

# make a db from the edta fasta file
makeblastdb -in ${in_dir}/canu/pilon.fasta.mod.EDTA.TElib.fa -dbtype nucl -out ${in_dir}/canu/blast_db/edta
makeblastdb -in ${in_dir}/flye/pilon.fasta.mod.EDTA.TElib.fa -dbtype nucl -out ${in_dir}/flye/blast_db/edta

#blast the consensus sequence against the library
blastn -query ${te}/canu/te_element.fasta -db ${in_dir}/canu/blast_db/edta -outfmt 6 -num_threads 10 -max_hsps 1 > ${in_dir}/canu/edta_te_element.blastn
#blastn -query ${te}/flye/te_element.fasta -db ${in_dir}/flye/blast_db/edta -outfmt 6 -num_threads 10 -max_hsps 1 > ${in_dir}/flye/edta_te_element.blastn


