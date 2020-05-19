#!/bin/bash

WAGL_VERSION='5.3.1-gadi'

module use /g/data/v10/public/modules/modulefiles
module use /g/data/v10/private/modules/modulefiles

module load "wagl/${WAGL_VERSION}"

START=$1
END=$2
INPUT_DIR=$3
OUTPUT_DIR=$4

# Fix me use the date type
if [ "$END" = "2019-12-32" ]; then
    END=2020-01-01
elif [ "$END" = "2020-01-32" ]; then
    END=2020-02-01
elif [ "$END" = "2020-02-30" ]; then
    END=2020-03-01
elif [ "$END" = "2020-03-32" ]; then
    END=2020-04-01
elif [ "$END" = "2020-04-31" ]; then
    END=2020-05-01
elif [ "$END" = "2020-05-32" ]; then
    END=2020-06-01
elif [ "$END" = "2020-06-31" ]; then
    END=2020-07-01
elif [ "$END" = "2020-07-32" ]; then
    END=2020-08-01
elif [ "$END" = "2020-08-32" ]; then
    END=2020-09-01
elif [ "$END" = "2020-09-31" ]; then
    END=2020-10-01
elif [ "$END" = "2020-10-32" ]; then
    END=2020-11-01
elif [ "$END" = "2020-11-31" ]; then
    END=2020-12-01
fi

echo $START $END
echo $INPUT_DIR $OUTPUT_DIR
./s2-nci-processing_l1yaml.py generate-level1 --level1-root "$INPUT_DIR" --copy-parent-dir-count 1 --output-dir  "$OUTPUT_DIR" --start-date "$START"  --end-date "$END" --log-level "INFO"
