#!/bin/bash

#!/bin/bash
#PBS -P v10
#PBS -W umask=017
#PBS -q normal
#PBS -l walltime=4:00:00,mem=75GB,other=pernodejobfs
#PBS -l wd
#PBS -l storage=gdata/v10+scratch/v10+gdata/if87+gdata/fj7+scratch/fj7+scratch/u46+gdata/u46
#PBS -l ncpus=15
# This value should be $END-$START+1


INPUT_DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2020/2020-01/'
OUTPUT_DIR='/g/data/v10/AGDCv2/indexed_datasets/cophub/s2/s2_l1c_yamls'

START=17
END=31
PARA="$(($END-$START+1))"
for i in $(seq  $START $END);
    # DAY_START DAY_END $INPUT_DIR $OUTPUT_DIR
    do echo 2020-01-$i 2020-01-$(($i+1)) $INPUT_DIR $OUTPUT_DIR ;
#done | xargs -P$PARA -n 4 ./repeat.sh
done | xargs -P$PARA -n 4 ./level1.sh
echo ncpus=$PARA    # set this value in line 10 above!


