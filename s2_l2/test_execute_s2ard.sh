#!/bin/bash

loc=$PWD
RUNDIR=$loc/logdir
S2L1DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2022/2022-02/15S140E-20S145E/'
LOGDIR=$loc/logdir_v1
WORKDIR=$loc/workdir
OUTPUT=$loc/pkgdir_v1
ENV=$loc/definitive.env

mkdir -p $LOGDIR
mkdir -p $WORKDIR
mkdir -p $OUTPUT

./execute_s2ard \
    --project u46 \
    --level1-dir $S2L1DIR \
    --workdir $WORKDIR \
    --logdir $LOGDIR \
    --output-dir $OUTPUT \
    --copy-parent-dir-count 1 \
    --file-mod-start  2022-02-26 \
    --file-mod-end  2022-02-27 \
    --task level2 \
    --rundir $RUNDIR \
    --env  $ENV

echo log directory $LOGDIR
echo output directory  $OUTPUT
echo input directory  $S2L1DIR
