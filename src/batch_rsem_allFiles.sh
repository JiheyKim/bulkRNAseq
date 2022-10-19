for f1 in fastq/*_R1.fastq.gz;do
        f2=${f1/_R1/_R2};
        n=${f1%_R1.fastq.gz};
        n=${n##*/}
        bash rsem-calculate-expression.sh $f1 $f2 \
        /mnt/beegfs/kimj23/rsem_genome/rsem_ref/grch38 \
        rsem/$n
done
#bash rsem-calculate-expression.sh  \
#ALS-09_ACAGTG_R1.fastq.gz  \
#ALS-09_ACAGTG_R2.fastq.gz  \
#/mnt/beegfs/kimj23/rsem_genome/rsem_ref/grch38 \
#rsem/out
