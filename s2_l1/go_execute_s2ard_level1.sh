#!/bin/bash

# this is an upgrade from 5.3.2-gadi
WAGL_VERSION='5.3.1-sentinel2-gadi-l1c-upgrade'

module use /g/data/v10/public/modules/modulefiles
module use /g/data/v10/private/modules/modulefiles

module load "wagl/${WAGL_VERSION}"

TEST=true

if [ "$TEST" = true ] ; then
  echo 'Using test directories'
  S2L1DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2019/2019-12/20S125E-25S130E/'
  LOGDIR=$PWD/logexedir/
  OUTPUT=$PWD/yamltestdir/
  ENV=$PWD/definitive.env

  pwd
  mkdir -p $LOGDIR
  mkdir -p $OUTPUT/20S125E-25S130E
fi

./s2-nci-processing_l1yaml.py \
    generate-level1 \
    --level1-root "$S2L1DIR" \
    --copy-parent-dir-count 1 \
    --output-dir "$OUTPUT" \
    --start-date  2019-12-08 \
    --end-date 2019-12-09 \
     --log-level "INFO"

