#!/bin/bash

module use /g/data/v10/public/modules/modulefiles
module load dea

./check.sh

./archive_scenes.py   --scene-dirs-file  /g/data/v10/work/s2_c3_ard/20230111T090000_ard/batchid-9f4c9a94ae/level-1-final_state-pending.txt  --archive

./check.sh
