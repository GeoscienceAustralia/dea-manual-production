#!/bin/bash

# ssh lpgs@gadi-dm.nci.org.au /home/547/lpgs/sandbox/dea-manual-production/landsat_c3/submit_go_reprocess.sh

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
