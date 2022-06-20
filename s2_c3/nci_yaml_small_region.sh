#!/usr/bin/env bash
set -x

# s2 l1 Metadata and indexing back-processing script
# for one month and regions within one 5 deg box directory
# This file is generated in the dev_no_merge branch

queue="normal"
ncpus="48 "
module="eodatasets3/0.28.3"
inputdir="/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/"
dry_run=" "
index="--index "

project="v10"
base_dir="/g/data/v10/work/s2_c3_ard"
yamdir="/g/data/ka08/ga/l1c_metadata"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
aoi=$SCRIPT_DIR/"regions_25S135E-30S140E_only.txt"
config_arg="--config $SCRIPT_DIR/datacube.conf "

aftermonth="2022-01"
beforemonth="2022-01"
verbose=" "

# Having the info above as variables and some empty values
# means I can easily test by adding some test code here
# without modifying the code below.


mkdir -p $base_dir/logdir

qsub -N nci_yaml_job \
     -q  $queue  \
     -W umask=33 \
     -l wd,walltime=0:40:00,mem=192GB,ncpus=$ncpus -m abe \
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
--after-month $aftermonth \
--before-month $beforemonth \
$dry_run \
$index \
$config_arg \
--only-regions-in-file $aoi \
--output-base $yamdir \
$inputdir"
