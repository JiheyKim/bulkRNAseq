NPROC=8
STAR_PATH=~/data/star/STAR-2.5.3a/bin/Linux_x86_64
r=~/data/rsem/grcm38/grcm38

 for f1 in ./*R1_cutadapt.fastq.gz;do
        n=${f1##*/}; n=${n%_S*};
        f2=${f1//R1/R2};
        o=exp/$n
        echo "
        #!/bin/sh
        #BSUB -o %J.bsub.out
        #BSUB -e %J.bsub.err
        #BSUB -J $o
        #BSUB -R rusage[mem=32] span[hosts=1] 

        mkdir -p ${o%/*}
        rsem-calculate-expression -p $NPROC --paired-end \
                --star --star-path $STAR_PATH \
                --estimate-rspd \
                --star-gzipped-read-file \
                --append-names \
                --output-genome-bam \
                $f1 $f2 $r $o
        " | bsub
done
exit

STAR_PATH=~/data/star/STAR-2.5.3a/bin/Linux_x86_64
r=~/data/rsem/grcm38/grcm38

for file in *_R1_cutadapt.fastq.gz; do
        run() {
        filename=$(basename "$file")
        INPUT1=`echo $filename | perl -ne 'if($_ =~ /((\S+)_(R1_cutadapt)\.fastq\.gz)/){print $1;}'`
        INPUT2=`echo $INPUT1 | perl -ne '$_ =~ s/R1/R2/;print $_;'`
        OUTDIR=`echo $filename | perl -ne 'if($_ =~ /((\S+)_(R1_cutadapt)\.fastq\.gz)/){print $2;}'`
        cmd='
#!/bin/sh
#BSUB -o /beevol/home/kimji/Ghosh/Ghosh_WMvsNAWM/test/rsem.out.%J
#BSUB -e /beevol/home/kimji/Ghosh/Ghosh_WMvsNAWM/test/rsem.err.%J
#BSUB -J sortSam
#BSUB -R rusage[mem=16] span[hosts=1]

 		mkdir -p OUTDIR
 		rsem-calculate-expression -p 8 --paired-end \
                --star --star-path ~/data/star/STAR-2.5.3a/bin/Linux_x86_64 \
                --estimate-rspd \
                --star-gzipped-read-file \
                --append-names \
                --output-genome-bam \
                INPUT1 INPUT2 ~/data/rsem/grcm38/grcm38 OUTDIR
        '
        cmd=${cmd/filename/$filename};
        cmd=${cmd//INPUT1/$INPUT1};
        cmd=${cmd//INPUT2/$INPUT2};
        cmd=${cmd//OUTDIR/$OUTDIR};

        echo "$cmd" > test_bsub.sh
        #bsub < test_bsub.sh
        #`$cmd`
        }
        run
done
