#!/bin/bash
# If a number is passed in it is assumed to be the scene limit
# otherwise the default is 400

#PBS -P v10
#PBS -W umask=017
#PBS -q express
#PBS -l walltime=02:00:00,mem=155GB,other=pernodejobfs
#PBS -l wd
#PBS -l storage=gdata/v10+scratch/v10+gdata/if87+gdata/xu18+scratch/xu18+scratch/u46+gdata/u46
#PBS -l ncpus=1

set -o errexit
set -o xtrace

if [[ "$HOSTNAME" == *"gadi"* ]]; then
	echo If module load breaks check out a clean environment
	module use /g/data/v10/public/modules/modulefiles
	module use /g/data/v10/private/modules/modulefiles

	module load ard-scene-select-py3-dea/20230525

fi

if [ -z "$1" ]
  then
    echo "No argument supplied"
	scene_limit_value=400
else
	scene_limit_value=$1
fi

dry_run=" "
run_ard="--run-ard"
scene_limit_value=1
dry_run="--dry-run"
run_ard=""
ard_env="/g/data/v10/projects/c3_ard/dea-ard-scene-select/scripts/prod/ard_env/prod-wagl-ls.env"
index_arg="--index-datacube-env /g/data/v10/projects/c3_ard/dea-ard-scene-select/scripts/prod/ard_env/index-datacube.env"
ard_path="/g/data/xu18/ga/"
new_ard_path="/g/data/xu18/ga/reprocessing_staged_for_removal"

project="v10"
pkgdir="/g/data/xu18/ga"
date=$(date '+%Y%m%dT%H%M%S')
basedir="/g/data/v10/work/ls_c3_ard"

logdir="$basedir/logdir/${date}_reprocess"
workdir="$basedir/workdir/${date}_reprocess"

mkdir -p "$logdir"
mkdir -p "$workdir"


# ard-reprocessed-l1s module
ard-reprocessed-l1s --walltime 10:00:00 \
--pkgdir  "$pkgdir" \
--logdir "$logdir"  \
--workdir "$workdir" \
--project "$project"  \
--env "$ard_env"  \
--current-base-path $ard_path \
--new-base-path $new_ard_path \
--scene-limit $scene_limit_value \
$dry_run \
$run_ard \
$index_arg
