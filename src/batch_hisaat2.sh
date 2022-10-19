#!/bin/bash

#BowtieIndex="/storage01/home/kimji/Bowtie_index/illumina_human_37_2"
for file in *_R1_cutadapt.fastq.gz; do
        run() {
        filename=$(basename "$file")
        INPUT1=`echo $filename | perl -ne 'if($_ =~ /((\S+)_(R1_cutadapt)\.fastq\.gz)/){print $1;}'`
        INPUT2=`echo $INPUT1 | perl -ne '$_ =~ s/R1/R2/;print $_;'`
        OUTSAM=`echo $filename | perl -ne 'if($_ =~ /((\S+)_(R1_cutadapt)\.fastq\.gz)/){print $2,".sam";}'`
        OUTBAM=`echo $filename | perl -ne 'if($_ =~ /((\S+)_(R1_cutadapt)\.fastq\.gz)/){print $2,"_byHisat2c.bam";}'`
        OUTSORTBAM=`echo $filename | perl -ne 'if($_ =~ /((\S+)_R1_cutadapt\.fastq\.gz)/){print $2,"_byHisat2c_sort";}'`

        cmd='
#!/bin/sh
#BSUB -o /beevol/home/kimji/Ghosh/Ghosh_GM/hisat2.out.%J
#BSUB -e /beevol/home/kimji/Ghosh/Ghosh_GM/hisat2.err.%J
#BSUB -J hisat2
#BSUB -R rusage[mem=32] span[hosts=1] 

hisat2 -f -p 16 -x /beevol/home/kimji/Bowtie_index/grch38_snp_tran/genome_snp_tran --dta-cufflinks -q -1 INPUT1 -2 INPUT2 -S OUTSAM

#samtools view -Sb OUTSAM > OUTBAM
#samtools sort OUTBAM OUTSORTBAM
        '
            cmd=${cmd/INPUT1/$INPUT1};
            cmd=${cmd/INPUT2/$INPUT2};
            cmd=${cmd/OUTSAM/$OUTSAM};
            cmd=${cmd/OUTSAM/$OUTSAM};
            cmd=${cmd/OUTBAM/$OUTBAM};
            cmd=${cmd/OUTBAM/$OUTBAM};
            cmd=${cmd/OUTSORTBAM/$OUTSORTBAM};


        echo "$cmd" > test_bsub.sh
        bsub < test_bsub.sh
        #`$cmd`
        }
        run INPUT1 INPUT2 OUTSAM OUTBAM OUTSORTBAM
done