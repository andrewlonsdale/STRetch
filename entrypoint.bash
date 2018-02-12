#!/bin/bash

# Based on the nuceleotid.es API 
# http://nucleotid.es/


set -o errexit
set -o xtrace
set -o nounset
INPUT="/input"
OUTPUT="/output"

FASTQ=${INPUT}
RESULTS=${OUTPUT}/STR.stdout
LOG=${OUTPUT}/STR.stderr

PARAMS=${2:-}

case $1 in
    exome)
cd $OUTPUT && bpipe run $PARAMS /STRetch/pipelines/STRetch_exome_pipeline.groovy ${FASTQ}/*.fastq.gz 1> $RESULTS 2> $LOG
        ;;
    wgs-bam)
cd $OUTPUT && bpipe run $PARAMS /STRetch/pipelines/STRetch_wgs_bam_pipeline.groovy /input/region.bed ${FASTQ}/*.bam 1> $RESULTS 2> $LOG
        ;;
    wgs)
cd $OUTPUT && bpipe run $PARAMS /STRetch/pipelines/STRetch_wgs_pipeline.groovy ${FASTQ}/*.fastq.gz  1> $RESULTS 2> $LOG
        ;;
    *)
       echo "Invalid option"
 # You should have a default one too.
esac


#bpipe run STRetch/pipelines/STRetch_wgs_bam_pipeline.groovy STR_positions.bed *.bam

#bpipe run STRetch/pipelines/STRetch_wgs_pipeline.groovy *.fastq.gz 



#need to map user

