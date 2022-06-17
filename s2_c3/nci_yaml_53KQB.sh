#!/usr/bin/env bash
set -x

# s2 l1 Metadata and indexing back-processing script
# for one month and one region
# This file is generated in the dev_no_merge branch

queue="normal"
ncpus="1 "
config_arg=" "
module="eodatasets3/0.28.3"
inputdir="/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/"
dry_run=" "
index="--index "

#Safety. Remove to generate into production.
index=" "
dry_run="--dry-run "

project="v10"
base_dir="/g/data/v10/work/s2_c3_ard"
yamdir="/g/data/ka08/ga/l1c_metadata"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
aoi=$SCRIPT_DIR/"53KQB.txt"

aftermonth="2021-05"
beforemonth="2021-05"

verbose=" "
odc_env="--env datacube "

# Having the info above as variables and some empty values
# means I can easily test by adding some test code here
# without modifying the code below.

# #/* The sed command below will remove this block of test code
# sed '/#\/\*/,/#\*\// d' nci_yaml_53KQB.sh > ../../nci_yaml_53KQB.sh;chmod +x ../../nci_yaml_53KQB.sh
# sed '/#\/\*/,/#\*\// d' s2_c3/nci_yaml_53KQB.sh > ../nci_yaml_53KQB.sh
# mv ../nci_yaml_53KQB.sh s2_c3/nci_yaml_53KQB.sh

# inputdir="/g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2022/2022-01/25S135E-30S140E"
#config_arg="--config /g/data/u46/users/dsg547/sandbox/processingDEA/s2_pipeline/pipeline_test.conf"
config_arg="--config /g/data/u46/users/dsg547/sandbox/processingDEA/s2_pipeline/dsg547_dev.conf"

#dry_run="--dry-run "
dry_run=" "

#index=" "
index="--index "

# dsg547
odc_env=" "
project="u46"
base_dir="/g/data/u46/users/dsg547/test_data/s2_pipeline"
#yamdir="/g/data/u46/users/dsg547/test_data/s2_pipeline/yaml_nci_53KQB/"
#yamdir="/g/data/u46/users/dsg547/test_data/s2_pipeline/yaml_nci_preprod/"
yamdir="/g/data/u46/users/dsg547/test_data/s2_pipeline/yaml_nci_preprod_dsg/"
mkdir -p $yamdir
# #*/ The end of the sed removed block of code

mkdir -p $base_dir/logdir

qsub -N nci_yaml_job \
     -q  $queue  \
     -W umask=33 \
     -l wd,walltime=0:30:00,mem=100GB,ncpus=$ncpus -m abe \
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
$odc_env \
$inputdir"
