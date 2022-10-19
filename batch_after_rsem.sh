#!/bin/bash

nproc=16
echo "#!/bin/bash
#SBATCH --cpus-per-task=$nproc
#SBATCH --mem=64g
rsem-generate-data-matrix rsem/ALS-03_ATCACG.genes.results rsem/ALS-07_TTAGGC.genes.results rsem/ALS-10_GCCAAT.genes.results rsem/ALS-11_CAGATC.genes.results rsem/ALS-13_GATCAG.genes.results rsem/ALS-19_ATGTCA.genes.results rsem/ALS-04_CGATGT.genes.results rsem/ALS-08_TGACCA.genes.results rsem/ALS-09_ACAGTG.genes.results rsem/ALS-12_ACTTGA.genes.results rsem/ALS-14_TAGCTT.genes.results rsem/ALS-15_GGCTAC.genes.results rsem/ALS-16_CTTGTA.genes.results rsem/ALS-17_AGTCAA.genes.results rsem/ALS-18_AGTTCC.genes.results > ALS.counts.matrix
" | sbatch -N 1
