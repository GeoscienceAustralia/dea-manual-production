#!/bin/bash

loc=$PWD
RUNDIR='/g/data/v10/work/s2_ard/pbs/level1'
S2L1DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2019/2019-12'
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
    --file-mod-start  2019-12-06 \
    --file-mod-end  2019-12-14 \
    --task test \
    --rundir $RUNDIR \
    --env  $ENV\
