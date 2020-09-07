#!/bin/bash

loc=$PWD
RUNDIR='/g/data/v10/work/s2_ard/pbs/level2'
S2L1DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2016/2016-11'
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
    --file-mod-start  2016-11-08 \
    --file-mod-end  2017-03-18 \
    --task level2 \
    --rundir $RUNDIR \
    --env  $ENV

echo log directory $LOGDIR
echo output directory  $OUTPUT
echo input directory  $S2L1DIR


