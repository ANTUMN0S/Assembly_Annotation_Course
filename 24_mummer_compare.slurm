#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=02:00:00
#SBATCH --job-name=mummer_compare
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/mberger/assembly_course/evaluations/compare/mummer/output_mummer_comp_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/evaluations/compare/mummer/error_mummer_comp_%j.e
#SBATCH --partition=pcourseassembly

#set variable for directory paths
flye_dir=/data/users/mberger/assembly_course/assemblies/flye/assembly.fasta
canu_dir=/data/users/mberger/assembly_course/assemblies/canu/arabidopsis.contigs.fasta
out_dir=/data/users/mberger/assembly_course/evaluations
ref_file=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

#load the mummer module
module add UHTS/Analysis/mummer/4.0.0beta1
export PATH=/software/bin:$PATH

#execute NUCmer
nucmer --prefix ${out_dir}/compare/mummer/nucmer_flye_canu -b 1000 -c 1000 ${canu_dir} ${flye_dir}
nucmer --prefix ${out_dir}/compare/mummer/nucmer_canu_flye -b 1000 -c 1000 ${flye_dir} ${canu_dir}



#execute mummerplot
mummerplot -R ${canu_dir} -Q ${flye_dir} --filter -t png --large --fat --layout --prefix ${out_dir}/compare/mummer/mummerplot_comp1 ${out_dir}/compare/mummer/nucmer_flye_canu.delta
mummerplot -R ${flye_dir} -Q ${canu_dir} --filter -t png --large --fat --layout --prefix ${out_dir}/compare/mummer/mummerplot_comp2 ${out_dir}/compare/mummer/nucmer_canu_flye.delta
