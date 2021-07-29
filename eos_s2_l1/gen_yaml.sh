#!/bin/bash

#cd /g/data/if87/datacube/002/S2_MSI_ARD/packaged
pwd_now=$PWD
cd /g/data/u46/users/dsg547/test_data/s2_yaml_gen/l1_scenes
cd /g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/

today=$(date -I)

dates=()
for i in {0..120}; do
    new_year=$(date -d "$today -$i days" '+%Y')
    new_year_month=$(date -d "$today -$i days" '+%Y-%m')
    value=$new_year/$new_year_month
    if [[ ! " ${dates[@]} " =~ " ${value} " ]]; then
        dates+=( $value )
    fi
done

# Find all the directories for captures from the last 120 days. Not
# every day will exist yet, and not every day will ever exist (eg.
# satellite didn't pass over Australia on that day).

# We could probably use `ls` instead of `find` here, but I was using
# find. Use sed to append the known metadata file name instead of doing
# yet another (slow) directory retrieval.

# This entire process takes around 2.5 seconds for a 120 day period, in
# testing on 2020-05-25 on gadi.

# Whereas using the following took 1m40s for the same 120 days. Using
# `find ${dates[@]} -maxdepth 2 -name 'ARD-METADATA.yaml' | wc -l` as a
# command with the

echo Indexing datasets from ${dates[@]}
echo processing
#find ${dates[@]} -maxdepth 1 -mindepth 1 | sed 's|$|/.zip|' | xargs echo
#find ${dates[@]}  -maxdepth 2 -mindepth 1 
find ${dates[@]}  -maxdepth 2 -mindepth 1  | grep '.zip'

cd $pwd_now
