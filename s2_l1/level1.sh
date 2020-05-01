#!/bin/bash

WAGL_VERSION='5.3.1-gadi'

module use /g/data/v10/public/modules/modulefiles
module use /g/data/v10/private/modules/modulefiles

module load "wagl/${WAGL_VERSION}"

START=$1
END=$2
INPUT_DIR=$3
OUTPUT_DIR=$4

if [ "$END" = "2019-12-32" ]; then
    END=2020-01-01
fi

if [ "$END" = "2020-01-32" ]; then
    END=2020-02-01
fi

if [ "$END" = "2020-02-30" ]; then
    END=2020-03-01
fi

if [ "$END" = "2020-03-32" ]; then
    END=2020-04-01
fi

echo $START $END
echo $INPUT_DIR $OUTPUT_DIR
./s2-nci-processing_l1yaml.py generate-level1 --level1-root "$INPUT_DIR" --copy-parent-dir-count 1 --output-dir  "$OUTPUT_DIR" --start-date "$START"  --end-date "$END" --log-level "INFO"
#s2-nci-processing generate-level1 --level1-root "$INPUT_DIR" --copy-parent-dir-count 1 --output-dir  "$OUTPUT_DIR" --start-date "$START"  --end-date "$END"
