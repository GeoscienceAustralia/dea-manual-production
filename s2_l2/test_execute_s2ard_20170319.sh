#!/bin/bash

loc=$PWD
RUNDIR=$loc/logdir
S2L1DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2017/2017-12/30S175E-35S180E'
LOGDIR=$loc/logdir
WORKDIR=$loc/workdir
OUTPUT=$loc/pkgdir
ENV=$loc/definitive.env

./execute_s2ard \
    --project u46 \
    --level1-dir $S2L1DIR \
    --workdir $WORKDIR \
    --logdir $LOGDIR \
    --output-dir $OUTPUT \
    --copy-parent-dir-count 1 \
    --file-mod-start  2017-03-29 \
    --file-mod-end  2017-04-02 \
    --task level2 \
    --rundir $RUNDIR \
    --env  $ENV

echo log directory $LOGDIR
echo output directory  $OUTPUT
echo input directory  $S2L1DIR


