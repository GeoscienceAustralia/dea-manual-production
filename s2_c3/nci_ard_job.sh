#!/usr/bin/env bash
set -x

# s2 c3 ARD back-processing script

queue="copyq"
products_arg="""--products '["esa_s2am_level1_0", "esa_s2bm_level1_0"]'"""
wagl_env="/g/data/v10/projects/c3_ard/dea-ard-scene-select/scripts/prod/ard_env/prod-wagl-s2.env"

project="v10"
base_dir="/g/data/v10/work/s2_c3_ard"
yamdir=" --yamls-dir /g/data/ka08/ga/l1c_metadata"
config_arg=" "

scene_limit="--scene-limit 60"
days_to_exclude="--days-to-exclude '[\"2021-01-01:2021-08-31\",\"2022-01-01:2022-01-31\"]'"

run_ard_arg="--run-ard"
index_arg="--index-datacube-env /g/data/v10/projects/c3_ard/dea-ard-scene-select/scripts/prod/ard_env/index-datacube.env"
module_ass="ard-scene-select-py3-dea/20220516"
pkgdir="/g/data/ka08/ga/"

# Having the info above as variables and some empty values
# means I can easily test by adding some test code here
# without modifying the code below.

# #/* The sed command below will remove this block of test code
# sed '/#\/\*/,/#\*\// d' nci_ard_job.sh > ../../nci_ard_job.sh;chmod +x  ../../nci_ard_job.sh
# sed '/#\/\*/,/#\*\// d' s2_c3/nci_ard_job.sh > ../nci_ard_job.sh
# mv ../.sh s2_c3/nci_ard_job.sh


# dsg547
project="u46"
base_dir="/g/data/u46/users/dsg547/test_data/s2_pipeline"

#yamdir=" --yamls-dir /g/data/u46/users/dsg547/test_data/s2_pipeline/yaml_nci_53KQB/"
#yamdir=" --yamls-dir /g/data/u46/users/dsg547/test_data/s2_pipeline/yaml_nci_preprod_dsg/"
#yamdir=" --yamls-dir /g/data/u46/users/dsg547/test_data/s2_pipeline/yaml_nci_preprod/"

#config_arg="--config /g/data/u46/users/dsg547/sandbox/processingDEA/s2_pipeline/pipeline_test.conf"
#config_arg="--config /g/data/u46/users/dsg547/sandbox/processingDEA/s2_pipeline/dsg547_dev.conf"

# Index ARD into pipeline_test
index_arg="--index-datacube-env /g/data/u46/users/dsg547/sandbox/processingDEA/s2_pipeline/index-dsg547_dev.env"

# Dry or not?
scene_limit="--scene-limit 60000"
# run_ard_arg="--run-ard"
run_ard_arg=" "
index_arg=" "

#pkgdir=$base_dir/pkgdir_preprod_dsg
pkgdir="/g/data/ka08/give_me_access_to_v10_but_that_should_be_all"

# #*/ The end of the sed removed block of code

mkdir -p $pkgdir

mkdir -p $base_dir/workdir
mkdir -p $base_dir/logdir

qsub -N ard_scene_select \
     -q  $queue  \
     -W umask=33 \
     -l wd,walltime=02:40:00,mem=15GB,ncpus=1 -m abe \
     -l storage=gdata/ka08+scratch/ka08+gdata/v10+scratch/v10+gdata/if87+gdata/fj7+scratch/fj7+gdata/u46 \
     -P  $project -o $base_dir/logdir -e  $base_dir/logdir  \
     -- /bin/bash -l -c \
     "module use /g/data/v10/public/modules/modulefiles/; \
                  module use /g/data/v10/private/modules/modulefiles/; \
                  module load $module_ass; \
                  ard-scene-select \
                  $products_arg \
                  $config_arg \
                  --workdir $base_dir/workdir \
                  --pkgdir $pkgdir \
                  --logdir $base_dir/logdir \
                  --env $wagl_env  \
                  --project  $project \
                  --walltime 20:00:00 \
                  $index_arg \
                  $scene_limit \
                  $yamdir \
		  $days_to_exclude \
                  $run_ard_arg "
