#!/bin/bash

if [[ $HOSTNAME == *"gadi"* ]]; then
  echo "gadi - NCI"
  module use /g/data/v10/public/modules/modulefiles
  module use /g/data/v10/private/modules/modulefiles
  module load dea
fi

LOG_DIR="/g/data/v10/work/landsat_downloads/L8L1C2_logs/"
export CURRENT_DATE=$(date +'%Y%m%dT%H%M%S');
STER_LOG_DIR=${LOG_DIR}/${CURRENT_DATE}
mkdir -p $STER_LOG_DIR;

#PROD
# Used for downloading extra ls8/9 l1 c1 1999 - 5 April 2022
# The region  113_084 has been removed, since
# it has been downloaded and ARD processed from 1999 to Dec 2021, for ls7.
# Using the usgsdownloader repo branch ls_ARD_filtered
export ENVIRONMENT=NCI-DEF-PROD;/home/547/lpgs/sandbox/ls_ARD_filtered/usgsdownloader/usgsdownloader/go_usgs_downloader.sh --pipeline L7L1C2 --dryrun --logPath $LOG_DIR --startDate 20220301 --endDate 20220405 &> ${STER_LOG_DIR}/ls7_2022_extra_extent.log


#  --dryrun --oneScene
