#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=04:00:00
#SBATCH --job-name=average_ks
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/average_ks_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/average_ks_%j.e
#SBATCH --partition=pall

#directory variables
scripts=/data/courses/assembly-annotation-course/CDS_annotation/scripts
canu=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/canu/estimate_duplications
flye=/data/users/mberger/assembly_course/annotations/protein_coding_sequences/duplication/flye/estimate_duplications

#parse the PAML_yn00_results
cd ${canu}
awk '{print($1,$1,$6,$7,$5)}' PAML_yn00_results|sed 's/ /\t/g'|sed 's/__x__/\t/'|sed 's/_p//g'|cut -f 1,2,4,5,6|sed 's/dN=//'|sed 's/dS=//'|sed 's/omega=//'|awk '$4<5' > LER.wgd.kaks

cd ${flye}
awk '{print($1,$1,$6,$7,$5)}' PAML_yn00_results|sed 's/ /\t/g'|sed 's/__x__/\t/'|sed 's/_p//g'|cut -f 1,2,4,5,6|sed 's/dN=//'|sed 's/dS=//'|sed 's/omega=//'|awk '$4<5' > LER.wgd.kaks


#combine the .kaks and the .collinearity files
cd ${canu}
perl ${scripts}/add_ka_ks_to_collinearity_file.pl LER

cd ${flye}
perl ${scripts}/add_ka_ks_to_collinearity_file.pl LER


#calculate average Ks value for each syntenic block
cd ${canu}
perl ${scripts}/compute_ks_for_synteny_blocks.pl LER.collinearity.kaks

cd ${flye}
perl ${scripts}/compute_ks_for_synteny_blocks.pl LER.collinearity.kaks


#estimate KS peaks from Ks distribution (python seems to create some issues, so I comment it out for now
cd ${canu}
#python ${scripts}/plot_syntenic_blocks_ks_distri.py LER.synteny.blocks.ks.info 2 LER

cd ${flye}
#python ${scripts}/plot_syntenic_blocks_ks_distri.py LER.synteny.blocks.ks.info 2 LER

