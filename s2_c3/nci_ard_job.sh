#!/usr/bin/env bash
set -x

# s2 c3 ARD back-processing script

queue="copyq"
products_arg="""--products '["esa_s2am_level1_0", "esa_s2bm_level1_0"]'"""
wagl_env="/home/547/lpgs/sandbox/dea-manual-production/s2_c3/prod-wagl-s2.env"

project="v10"
base_dir="/g/data/v10/work/s2_c3_ard"
yamdir=" --yamls-dir /g/data/ka08/ga/l1c_metadata"
config_arg=" "

scene_limit="--scene-limit 10000"

#days_to_exclude="--days-to-exclude '[\"2022-08-01:2022-09-01\",\"2018-07-01:2022-06-30\",\"2015-07-01:2018-05-31\"]'"
#days_to_exclude="--days-to-exclude '[\"2022-08-01:2022-09-01\",\"2015-07-01:2022-06-30\"]'"
#days_to_exclude="--days-to-exclude '[\"2021-01-01:2022-02-28\",\"2020-01-01:2020-03-31\"]'"
#days_to_exclude="--days-to-exclude '[\"2019-01-01:2022-02-28\",\"2018-01-01:2018-03-31\"]'"
#days_to_exclude=" "
#days_to_exclude="--days-to-exclude '[\"2016-11-01:2023-12-31\"]'"
#days_to_exclude="--days-to-exclude '[\"2016-04-01:2023-12-31\"]'"
#days_to_exclude="--days-to-exclude '[\"2015-01-01:2016-09-01\"]'"
#days_to_exclude="--days-to-exclude '[\"2016-01-01:2022-07-01\"]'"
#days_to_exclude="--days-to-exclude '[\"2016-11-01:2024-01-31\"]'"
#days_to_exclude="--days-to-exclude '[\"2016-11-01:2023-12-31\"]'"
days_to_exclude="--days-to-exclude '[\"2015-07-01:2017-01-01\",\"2022-01-01:2025-01-01\"]'"
#days_to_exclude="--days-to-exclude '[\"2015-07-01:2022-08-31\",\"2022-10-01:2023-09-01\"]'"
#days_to_exclude="--days-to-exclude '[\"2015-07-01:2016-10-31\",\"2022-08-31:2023-09-01\"]'"
#days_to_exclude="--days-to-exclude '[\"2015-07-01:2016-10-31\",\"2017-01-01:2023-09-01\"]'"
#days_to_exclude="--days-to-exclude '[\"2015-07-01:2016-02-28\",\"2016-11-01:2023-09-01\"]'"
#days_to_exclude="--days-to-exclude '[\"2015-01-01:2015-07-31\",\"2015-12-01:2023-09-01\"]'"
#days_to_exclude="--days-to-exclude '[\"2015-01-01:2015-07-31\",\"2016-11-01:2023-09-01\"]'"
# days_to_exclude="--days-to-exclude '[\"2015-01-01:2022-08-31\"]'"
#days_to_exclude="--days-to-exclude '[\"2015-01-01:2015-12-31\",\"2017-01-01:2029-09-01\"]'"
#days_to_exclude="--days-to-exclude '[\"2017-01-01:2029-09-01\"]'"




run_ard_arg="--run-ard"
# run_ard_arg=" "
index_arg="--index-datacube-env /g/data/v10/work/landsat_downloads/landsat-downloader/config/dass-index-datacube.env"
module_ass="ard-scene-select-py3-dea/20230330"
pkgdir="/g/data/ka08/ga/"

# Having the info above as variables and some empty values
# means I can easily test by adding some test code here
# without modifying the code below.

CURRENT_DATE=$(date +'%Y%m%dT%H%M%S')

mkdir -p $pkgdir
workdir=$base_dir/workdir/${CURRENT_DATE}
logdir=$base_dir/logdir/${CURRENT_DATE}_ard
mkdir -p $workdir
mkdir -p $logdir

qsub -N ard_scene_select \
     -q  $queue  \
     -W umask=33 \
     -l wd,walltime=02:40:00,mem=15GB,ncpus=1 -m abe \
     -l storage=gdata/ka08+scratch/ka08+gdata/v10+scratch/v10+gdata/if87+gdata/fj7+scratch/fj7+gdata/u46 \
     -P  $project -o $logdir -e  $logdir  \
     -- /bin/bash -l -c \
     "module use /g/data/v10/public/modules/modulefiles/; \
                  module use /g/data/v10/private/modules/modulefiles/; \
                  module load $module_ass; \
                  ard-scene-select \
                  $products_arg \
                  $config_arg \
                  --workdir $workdir \
                  --pkgdir $pkgdir \
                  --logdir $logdir \
                  --env $wagl_env  \
                  --project  $project \
                  --walltime 20:00:00 \
                  $index_arg \
                  $scene_limit \
                  $yamdir \
		  $days_to_exclude \
                  $run_ard_arg "
