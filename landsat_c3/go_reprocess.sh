#!/bin/bash
# If a number is passed in it is assumed to be the scene limit
# otherwise the default is 400

set -o errexit
set -o xtrace

if [[ "$HOSTNAME" == *"gadi"* ]]; then
	echo If module load breaks check out a clean environment
	module use /g/data/v10/public/modules/modulefiles
	module use /g/data/v10/private/modules/modulefiles
  	# module use /g/data/u46/users/$USER/devmodules/modulefiles

	module load ard-scene-select-py3-dea/20230522

fi

dry_run=" "

if [ -z "$1" ]
  then
    echo "No argument supplied"
	scenelimitvalue=400
else
	scenelimitvalue=$1
fi
scenelimit="--scene-limit $scenelimitvalue"
project="v10"
pkgdir="/g/data/xu18/ga"
date=$(date '+%Y%m%d_%H%M%S')
basedir="/g/data/v10/work/ls_c3_ard/"

# #/* The sed command below will remove this block of test code
# and generate the production script called go_reprocess.sh
# sed '/#\/\*/,/#\*\// d' dev_go_reprocess.sh > go_reprocess.sh
# sed '/#\/\*/,/#\*\// d' landsat_c3/dev_go_reprocess.sh > landsat_c3/go_reprocess.sh

# run ['dev'|'prod']
run='dev'
#run='prod'
if [ "$run" = "prod" ]; then
   dry_run="--dry-run"

   # Need more info. It has to be just like an airflow prod run
   #index="--index "
else
   dryrun="--dry-run "
   index=" "
   scenelimit="--scene-limit 999999"
   project="u46"

   # Run the local scene select
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

	basedir="$DIR"/scratch/
	pkgdir=$basedir/pkgdir$RANDOM

	# use_db ['dev'|'prod']
	#use_db='dev'
	use_db='prod'
	if [ "$use_db" = "prod" ]; then
		echo "prod db being used."
   		dryrun="--dry-run "
	else
		DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
		export DATACUBE_CONFIG_PATH=$DIR/datacube.conf
		export DATACUBE_ENVIRONMENT="${USER}_dev"
	fi

   # Need more info. It has to be just like an airflow prod run
   #index="--index "
fi

logdir="$basedir/logdir/$date"
workdir="$basedir/workdir/$date"

mkdir -p "$pkgdir"
# #*/ The end of the sed removed block of code
mkdir -p "$logdir"
mkdir -p "$workdir"

ARD_ENV="/g/data/v10/projects/c3_ard/dea-ard-scene-select/scripts/prod/ard_env/prod-wagl-ls.env"

# ard-reprocessed-l1s module
ard-reprocessed-l1s --pkgdir  "$pkdir" --logdir "$logdir"  --workdir "$workdir" --project "$project"  --env "$ARD_ENV"  $scenelimit $dryrun
