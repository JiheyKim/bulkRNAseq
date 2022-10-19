#!/bin/bash

usage="$BASH_SOURCE <fastq1> <fastq2> <ref> <output>"
if [ $# -lt 4 ];then echo "$usage"; exit; fi

odir=$4
isgzip=""
[[ $1 =~ .*gz ]] && isgzip="--star-gzipped-read-file"
module load STAR
star=/cm/shared/apps/STAR/2.7.6a
nproc=16
echo "#!/bin/bash
#SBATCH --cpus-per-task=$nproc
#SBATCH --mem=64g
module load perl
module load STAR
mkdir -p ${odir%/*} # RSEM error
rsem-calculate-expression --paired-end $isgzip \
        --star --star-path $star -p $nproc \
        --estimate-rspd \
        --append-names \
        --no-bam-output \
        $@
" | sbatch -N 1
