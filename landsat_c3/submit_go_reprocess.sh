#!/bin/bash

# ssh lpgs@gadi-dm.nci.org.au /home/547/lpgs/sandbox/dea-manual-production/landsat_c3/submit_go_reprocess.sh

# location of the script and environment files used in production
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

basedir="/g/data/v10/work/ls_c3_ard"
#basedir=$DIR

# These logs could be with the other logs, but that would involve
# passing directory arguements around
logdir="$basedir/logdir/reprocess_e_o"
mkdir -p $logdir

# the e and o files are written to the log dir since
# the qsub call is from the logdir
cd $logdir

# low value file
PBS_LOG=$logdir/submit_ard_prod.log

qsub -v INIT_PWD=$DIR $DIR/go_reprocess.sh >>$PBS_LOG 2>&1
