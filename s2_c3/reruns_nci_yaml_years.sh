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


# run ['dry'|'actual']
run='dry'
#run='actual'
if [ "$run" = "actual" ]; then
    dry_run=" "
    index="--index "
else
    dry_run="--dry-run "
    # Doing this as lpgs
    # If the run is not a dry run, i want it indexed
    #index=" "
    cpus="1 "
    em="20GB"
    alltime="01:00:00"
    # base_dir=$SCRIPT_DIR
fi

# Having the info above as variables and some empty values
# means I can easily test by adding some test code here
# without modifying the code below.

# #/* The sed command below will remove this block of test code
# sed '/#\/\*/,/#\*\// d' nci_yaml_years.sh > ../../nci_yaml_years.sh;chmod +x ../../nci_yaml_years.sh
# sed '/#\/\*/,/#\*\// d' s2_c3/nci_yaml_years.sh > ../nci_yaml_years.sh
# mv ../nci_yaml_years.sh s2_c3/nci_yaml_years.sh

#inputdir="/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2021/"
#config_arg="--config /g/data/u46/users/dsg547/sandbox/processingDEA/s2_pipeline/pipeline_test.conf"
#config_arg="--config /g/data/u46/users/dsg547/sandbox/processingDEA/s2_pipeline/dsg547_dev.conf"

# dsg547
project="u46"
#base_dir="/g/data/u46/users/dsg547/test_data/s2_pipeline/eod29_5"
base_dir="/g/data/v10/Landsat-Collection-3-ops/yaml/15_16eod29_5"

# Keeping this so the ARD will work.
#yamdir="/g/data/u46/users/dsg547/test_data/s2_pipeline/yaml_nci_preprod/"
#mkdir -p $yamdir

# #*/ The end of the sed removed block of code
mkdir -p $base_dir/logdir

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
--after-month 2015-01 \
--before-month 2016-10 \
$dry_run \
$index \
$config_arg \
--only-regions-in-file $aoi \
--output-base $yamdir \
$inputdir"
