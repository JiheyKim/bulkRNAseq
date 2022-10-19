#!/bin/bash

echo "#!/bin/bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=64000

module load tophat
module load perl
module load bowtie2
mkdir 705SC

tophat -p 8 -o 705SC -G ~/beegfs/GENOME/mm10/gencode.vM22.annotation.gtf /home/kimj23/beegfs/GENOME/mm10/GRCm38 705SC_1_trim.fastq.gz 705SC_2_trim.fastq.gz 
" | sbatch -N 1
