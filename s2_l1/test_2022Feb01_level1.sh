#!/bin/bash

#!/bin/bash
#PBS -P v10
#PBS -W umask=017
#PBS -q normal
#PBS -l walltime=5:00:00,mem=155GB,other=pernodejobfs
#PBS -l wd
#PBS -l storage=gdata/v10+scratch/v10+gdata/if87+gdata/fj7+scratch/fj7
# If testing add this +gdata/u46+scratch/u46
#PBS -l ncpus=1
# This value should be $END-$START+1
# the mem is ncpu * 5 GB

INPUT_DIR='/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2022/'
OUTPUT_DIR='/g/data/v10/AGDCv2/indexed_datasets/cophub/s2/s2_l1c_yamls'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
OUTPUT_DIR=$SCRIPT_DIR/s2_l1c_yamls
mkdir -p $OUTPUT_DIR

INITIAL=2022-01-29 # The first date year-month-day
ncpus=1  # The number of dates and the ncpus. set this value in line 10 above too!

# Change the above lines, not the below lines
for i in $(seq $ncpus); do
   START=$(date +%Y-%m-%d -d "$INITIAL + $((i - 1)) day")
   END=$(date +%Y-%m-%d -d "$INITIAL + $i day")
   echo $START $END $INPUT_DIR $OUTPUT_DIR ;
#done | xargs -P $ncpus -n 4 ./repeat.sh
done | xargs -P $ncpus -n 4 ./level1simple.sh

echo ncpus=$ncpus    # set this value in line 10 above too!
