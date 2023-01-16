#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=04:00:00
#SBATCH --job-name=DupGen
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/DupGen_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/DupGen_%j.e
#SBATCH --partition=pall

cd /data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/canu
DupGen_finder.pl -i DupGen_input -t Ath -c Nnu -o DupGen_output

cd /data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/flye
DupGen_finder.pl -i DupGen_input -t Ath -c Nnu -o DupGen_output