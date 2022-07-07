#!/usr/bin/env bash

module use /g/data/v10/public/modules/modulefiles
module use /g/data/v10/private/modules/modulefiles
module load dea

#ODCCONF="--config pipeline_test.conf"
#ODCCONF="--config  dsg547_dev.conf"
ODCCONF=""


echo product='ga_s2am_ard_3'
datacube  $ODCCONF dataset search product='ga_s2am_ard_3' | grep '^id: ' | wc -l
#datacube  $ODCCONF dataset search product='ga_s2am_ard_3' | grep '^id: '

echo product='ga_s2bm_ard_3'
datacube  $ODCCONF dataset search product='ga_s2bm_ard_3' | grep '^id: ' | wc -l
#datacube  $ODCCONF dataset search product='ga_s2bm_ard_3' | grep '^id: '
