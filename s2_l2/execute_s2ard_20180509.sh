#!/bin/bash
# Running for product on 30-04-2018
#the file modification date of the files you want processed are within the file-mod-start and file-mod-end and the right directory is selected then the scenes will be accessed for ARD processing
# Note this is for gap filling dates that have no ard files.  This is different from fixing results that have missing check sums.

loc=$PWD
RUNDIR='/g/data/v10/work/s2_ard/pbs/level2'
S2L1DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2018/2018-04'
LOGDIR='/g/data/v10/work/s2_ard/wagl'
WORKDIR='/g/data/if87/workdir'
OUTPUT='/g/data/if87/datacube/002/S2_MSI_ARD/packaged'
ENV=$loc/definitive.env

./execute_s2ard \
    --project u46 \
    --level1-dir $S2L1DIR \
    --workdir $WORKDIR \
    --logdir $LOGDIR \
    --output-dir $OUTPUT \
    --copy-parent-dir-count 1 \
    --file-mod-start  2018-04-30 \
    --file-mod-end  2018-05-09 \
    --task level2 \
    --rundir $RUNDIR \
    --env  $ENV

echo log directory $LOGDIR
echo output directory  $OUTPUT
echo input directory  $S2L1DIR


