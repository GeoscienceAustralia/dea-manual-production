#!/bin/bash

loc=$PWD
RUNDIR='/g/data/v10/work/s2_ard/pbs/level1'
S2L1DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2017/2017-02'
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
    --file-mod-start  2017-03-05 \
    --file-mod-end  2017-04-02 \
    --task level2 \
    --rundir $RUNDIR \
    --env  $ENV

echo log directory $LOGDIR
echo output directory  $OUTPUT
echo input directory  $S2L1DIR


