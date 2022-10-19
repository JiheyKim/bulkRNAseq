
for file in *.sam; do
        run() {
        filename=$(basename "$file")
        INPUT1=`echo $filename | perl -ne 'if($_ =~ /((\S+)\.sam)/){print $1;}'`
        OUTBAM=`echo $filename | perl -ne 'if($_ =~ /((\S+)\.sam)/){print $2,"_sorted.bam";}'`
        cmd='
#!/bin/sh
#BSUB -o /beevol/home/kimji/Ghosh/Ghosh_GM/sortSam.out.%J
#BSUB -e /beevol/home/kimji/Ghosh/Ghosh_GM/sortSam.err.%J
#BSUB -J sortSam
#BSUB -R rusage[mem=32] span[hosts=1]

hm sam.merge INPUT1 > OUTBAM
        '
        cmd=${cmd/filename/$filename};
        cmd=${cmd//INPUT1/$INPUT1};
        cmd=${cmd//OUTBAM/$OUTBAM};

        echo "$cmd" > test_bsub.sh
        bsub < test_bsub.sh
        #`$cmd`
        }
        run
done