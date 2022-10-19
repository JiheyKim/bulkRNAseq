#!/bin/bash

nproc=16
echo "#!/bin/bash
#SBATCH --cpus-per-task=$nproc
#SBATCH --mem=64g

java -jar /cm/shared/apps/trimmomatic/0.39/trimmomatic-0.39.jar PE 705SC_1.fastq.gz 705SC_2.fastq.gz 705SC_1_trim.fastq.gz 705SC_1_unpaired.fastq.gz 705SC_2_trim.fastq.gz 705SC_2_unpaired.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36
" | sbatch -N 1
