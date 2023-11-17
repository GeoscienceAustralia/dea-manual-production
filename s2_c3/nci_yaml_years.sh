#!/usr/bin/env bash
set -x

# s2 l1 Metadata and indexing back-processing script
# for multiple months and all of the Australian area of interest
# This file is generated in the dev_no_merge branch

queue="normal"
ncpus="48 "
mem="192GB"
walltime="08:00:00"

module="eodatasets3/0.29.5"
inputdir="/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/"

project="v10"
base_dir="/g/data/v10/work/s2_c3_ard"
yamdir="/g/data/ka08/ga/l1c_metadata"

aoi="/g/data/v10/projects/c3_ard/dea-ard-scene-select/scene_select/data/Australian_tile_list_optimised.txt"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
config_arg="--config $SCRIPT_DIR/datacube.conf "

verbose=" "

year=2023
months=(01 02 03 04 05 06 07 08 09 10 11 12)

#months=(10)

# run ['dry'|'actual']
run='dry'
#run='actual'
if [ "${run}" = "actual" ]; then
   dry_run=" "
   index="--index "
else
   dry_run="--dry-run "
   index=" "
   ncpus="1 "
   mem="20GB"
   walltime="01:00:00"
   months=(01)
   aoi="/g/data/v10/work/landsat_downloads/landsat-downloader/config/51LWD.txt"
fi

# Having the info above as variables and some empty values
# means I can easily test by adding some test code here
# without modifying the code below.

mkdir -p $base_dir/logdir

for month in "${months[@]}"; do
qsub -N nci_yaml_job \
     -q  $queue  \
     -W umask=33 \
     -l wd,walltime=$walltime,mem=$mem,ncpus=$ncpus -m abe \
     -l storage=gdata/ka08+scratch/ka08+gdata/v10+scratch/v10+gdata/if87+gdata/fj7+scratch/fj7+gdata/u46 \
     -P  $project -o $base_dir/logdir -e  $base_dir/logdir  \
     -- /bin/bash -l -c \
     "module use /g/data/v10/public/modules/modulefiles/; \
module use /g/data/v10/private/modules/modulefiles/; \
module load $module; \
set -x; \
eo3-prepare sentinel-l1  \
$verbose \
--jobs $ncpus  \
--after-month $year-$month \
--before-month $year-$month \
$dry_run \
$index \
$config_arg \
--only-regions-in-file $aoi \
--output-base $yamdir \
$inputdir"
done
