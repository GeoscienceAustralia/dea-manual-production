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
# Used for downloading extra 9 l1 c2 2013 - 2021
# Reduced extras region list since ARDs have been produced, from l1 c1, for some of the extra regions.
# Using the usgsdownloader repo branch ls_ARD_filtered
export ENVIRONMENT=NCI-DEF-PROD;/home/547/lpgs/sandbox/ls9_only_download/usgsdownloader/usgsdownloader/go_usgs_downloader.sh --pipeline L89L1C2EXTRA --logPath $LOG_DIR  --startDate 20211101 --endDate 20211231 --dryrun &> ${STER_LOG_DIR}/pre_2022_ls9_extra_extent.log


#  --dryrun --oneScene
