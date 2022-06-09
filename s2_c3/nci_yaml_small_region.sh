#!/usr/bin/env bash
set -x

# s2 l1 Metadata and indexing back-processing script
# for one month and one region

queue="normal"
ncpus="48 "
config_arg=" "
module="eodatasets3/0.28.2"
inputdir="/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/"
dry_run=" "
index="--index "

#Safety. Remove to generate into production.
index=" "
dry_run="--dry-run "

project="v10"
base_dir="/g/data/v10/work/s2_c3_ard/"
yamdir="/g/data/ka08/ga/l1c_metadata"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
aoi=$SCRIPT_DIR/"regions_25S135E-30S140E_only.txt"

aftermonth="2022-01"
beforemonth="2022-01"
verbose=" "

# Having the info above as variables and some empty values
# means I can easily test by adding some test code here
# without modifying the code below.

# #/* The sed command below will remove this block of test code
# sed '/#\/\*/,/#\*\// d' nci_yaml_small_region.sh > ../../nci_yaml_small_region.sh
# sed '/#\/\*/,/#\*\// d' s2_c3/nci_yaml_small_region.sh > ../nci_yaml_small_region.sh
# mv ../nci_yaml_small_region.sh s2_c3/nci_yaml_small_region.sh

# inputdir="/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2022/2022-01/25S135E-30S140E"
config_arg="--config /g/data/u46/users/dsg547/sandbox/processingDEA/s2_pipeline/pipeline_test.conf"
#config_arg="--config /g/data/u46/users/dsg547/sandbox/processingDEA/s2_pipeline/dsg547_dev.conf"

dry_run=" "
index="--index "
#verbose="--verbose "

# dsg547
project="u46"
base_dir="/g/data/u46/users/dsg547/test_data/s2_pipeline"

# Keeping this so the ARD will work.
yamdir="/g/data/u46/users/dsg547/test_data/s2_pipeline/yaml_nci_preprod/"
mkdir -p $yamdir

# #*/ The end of the sed removed block of code

mkdir -p $base_dir/logdir

qsub -N nci_yaml_job \
     -q  $queue  \
     -W umask=33 \
     -l wd,walltime=0:40:00,mem=100GB,ncpus=$ncpus -m abe \
     -l storage=gdata/v10+scratch/v10+gdata/if87+gdata/fj7+scratch/fj7+gdata/u46 \
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
