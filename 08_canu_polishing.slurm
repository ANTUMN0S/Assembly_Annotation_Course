#!/usr/bin/env bash

#SBATCH --time=3-00:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH --cpus-per-task=4
#SBATCH --partition=pcourseassembly
#SBATCH --job-name=canu_polish
#SBATCH --mail-user=michael.berger1@students.unibe.ch
#SBATCH --mail-type=begin,fail,end
#SBATCH --output=/data/users/mberger/assembly_course/polishing/canu/output_canu_%j.o
#SBATCH --error=/data/users/mberger/assembly_course/polishing/canu/error_canu_%j.e

#set input and output directory variables
input_raw=/data/users/mberger/assembly_course/participant_4/Illumina
input_assemblies=/data/users/mberger/assembly_course/assemblies/canu
output_dir=/data/users/mberger/assembly_course/polishing/canu

#load the modules
module load UHTS/Aligner/bowtie2/2.3.4.1
module load UHTS/Analysis/samtools/1.10
module load Development/java/11.0.6

#run bowtie2-build to index the assembly
bowtie2-build --threads 4 -f ${input_assemblies}/arabidopsis.contigs.fasta ${output_dir}/canu_index

#run bowtie2 in alignment mode --sensitive-local
bowtie2 -p 4 -x ${output_dir}/canu_index -1 ${input_raw}/*_1.fastq.gz -2 ${input_raw}/*_2.fastq.gz \
-q --sensitive-local -S ${output_dir}/canu_polish.sam

#change directory
cd ${output_dir}

#convert to the samfile to bamfile
samtools sort -T $SCRATCH -@ $SLURM_CPUS_PER_TASK canu_polish.sam -o canu_sorted.sam
samtools view -bS canu_sorted.sam -o canu_polish.bam
samtools index canu_polish.bam

#run pilon
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
--genome ${input_assemblies}/arabidopsis.contigs.fasta \
--bam ${output_dir}/canu_polish.bam --outdir ${output_dir} --output pilon
