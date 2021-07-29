#!/bin/bash

#cd /g/data/if87/datacube/002/S2_MSI_ARD/packaged
pwd_now=$PWD
cd /g/data/u46/users/dsg547/test_data/s2_yaml_gen/l1_scenes
cd /g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/
yamlbase=/g/data/v10/AGDCv2/indexed_datasets/cophub/s2/s2_l1c_yamls

today=$(date -I)

dates=()
for i in {0..10}; do
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

# These are all the zips in the recent months 
zips=() 
for dir_struct in ${dates[@]}; do
    while IFS=  read -r -d $'\0'; do
	zips+=("$REPLY")
    done < <(find $dir_struct  -maxdepth 2 -mindepth 1 -name '*.zip' -print0)
  #find $dir_struct  -maxdepth 2 -mindepth 1 -name '*.zip'
done

echo the zips ${zips[@]}

# Lets filter out all the zips that already have yamls
for zip_struct in  ${zips[@]}; do
    echo $zip_struct
done


cd $pwd_now
