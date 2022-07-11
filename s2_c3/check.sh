#!/usr/bin/env bash

module use /g/data/v10/public/modules/modulefiles
module use /g/data/v10/private/modules/modulefiles
module load dea

#ODCCONF="--config pipeline_test.conf"
#ODCCONF="--config  dsg547_dev.conf"
ODCCONF=""

  
echo product='esa_s2am_level1_0'
 datacube  $ODCCONF dataset search product='esa_s2am_level1_0' | grep '^id: ' | wc -l

echo product='esa_s2bm_level1_0'
datacube  $ODCCONF dataset search product='esa_s2bm_level1_0' | grep '^id: ' | wc -l

echo product='ga_s2am_ard_3'
datacube  $ODCCONF dataset search product='ga_s2am_ard_3' | grep '^id: ' | wc -l

echo product='ga_s2bm_ard_3'
datacube  $ODCCONF dataset search product='ga_s2bm_ard_3' | grep '^id: ' | wc -l
