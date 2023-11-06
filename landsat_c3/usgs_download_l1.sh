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
# Check with Duncan before downloading pre 2022 data
export ENVIRONMENT=NCI-DEF-PROD;/home/547/lpgs/sandbox/usgsdownloader/usgsdownloader/go_usgs_downloader.sh --pipeline L8L1C2 --logPath $LOG_DIR --startDate 20231001 --endDate 20231016 &> ${STER_LOG_DIR}/extra_extent.log
# /scratch/v10/USGSM2M/
#  --oneScene
# --dryrun

# NCI-DEF-DEV
# export ENVIRONMENT="NCI-DEF-DEV";$DIR/../usgsdownloader/go_usgs_downloader.sh --pipeline L7L1C2 --log INFO --logPath $SCRATCH --dryrun   --oneScene
# export ENVIRONMENT="NCI-DEF-DEV";$DIR/../usgsdownloader/go_usgs_downloader.sh --pipeline L8L1C2 --log INFO --logPath $SCRATCH --dryrun   --startDate 20220101 --endDate 20220323 #  --oneScene
# export ENVIRONMENT="LOCAL-DEV";$DIR/../usgsdownloader/go_usgs_downloader.sh --pipeline L8L1C2 --log INFO --logPath $SCRATCH --dryrun  --startDate 20220101 --endDate 20220317
# /g/data/u46/users/dsg547/dump/LSL1C2
