#!/bin/bash

# ssh lpgs@gadi-dm.nci.org.au /g/data/v10/projects/c3_ard/dea-ard-scene-select/scripts/prod/submit_ard_prod.sh

# location of the script and environment files used in production
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Capturing the .e & .o files in a run dir
date=$(date '+%Y%m%dT%H%M')
basedir="/g/data/v10/work/ls_c3_ard"
#basedir=$DIR

logdir="$basedir/logdir/${date}_reprocess"
mkdir -p $logdir
cd $logdir

PBS_LOG=$logdir/submit_ard_prod.log

qsub -v INIT_PWD=$DIR $DIR/go_reprocess.sh >>$PBS_LOG 2>&1
