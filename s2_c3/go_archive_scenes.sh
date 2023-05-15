#!/bin/bash

module use /g/data/v10/public/modules/modulefiles
module load dea

./check.sh
./archive_scenes.py  --scene-dirs-file /home/547/lpgs/sandbox/dea-manual-production/s2_c3/level-1-final_state-pending.txt  --archive
#./archive_scenes.py   --scene-dirs-file  /g/data/v10/work/s2_c3_ard/logdir/20230415T090000_ard/batchid-f3216fd349/level-1-final_state-pending.txt --archive

./check.sh
