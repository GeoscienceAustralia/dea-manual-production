#!/bin/bash

loc=$PWD
RUNDIR='/g/data/v10/work/s2_ard/pbs/level1'
S2L1DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2019/2019-12/'
LOGDIR='/g/data/v10/work/s2_ard/wagl'
WORKDIR='/g/data/if87/workdir'
OUTPUT='/g/data/if87/datacube/002/S2_MSI_ARD/packaged'
ENV=$loc/definitive.env


#TEST=False
TEST=true

if [ "$TEST" = true ] ; then
  echo 'Using test directories'
  S2L1DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2019/2019-12/20S125E-25S130E/'
  LOGDIR=$loc/logexedir/
  RUNDIR=$LOGDIR
  WORKDIR=$loc/workexedir/
  OUTPUT=$loc/pkgexedir/
  ENV=$loc/definitive.env

  mkdir -p $LOGDIR
  mkdir -p $WORKDIR
  mkdir -p $OUTPUT
fi

./execute_s2ard \
    --project u46 \
    --level1-dir $S2L1DIR \
    --workdir $WORKDIR \
    --logdir $LOGDIR \
    --output-dir $OUTPUT \
    --copy-parent-dir-count 1 \
    --file-mod-start  2019-12-08 \
    --file-mod-end  2019-12-09 \
    --task level2 \
    --rundir $RUNDIR \
    --env  $ENV\
    --obs-year 2019

#./execute_s2ard --project u46 \
#  --level1-dir /g/data/fj7/Copernicus/Sentinel-2/MSI/L1C \
#  --output-dir /g/data/u46/users/dsg547/sandpit/processingDEA/s2_processing/yamldir \
#  --copy-parent-dir-count 1 \
#  --file-mod-start 2019-12-28 \
#  --file-mod-end 2019-12-29 \
#  --task level1 \
#  --rundir $PWD \
#  --obs-year 2019
