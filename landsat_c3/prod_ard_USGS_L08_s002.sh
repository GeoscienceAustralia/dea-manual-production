source /g/data/v10/Landsat-Collection-3-ops/OFFICIAL/Collection-3_5.4.1.env
ard_pbs --level1-list /g/data/u46/users/dsg547/results/DataCube_L08_CollectionUpgrade_Level1_list_USGS_s002 --workdir  /g/data/v10/projects/landsat_c3/wagl_workdir --logdir /g/data/v10/projects/landsat_c3/wagl_logdir --pkgdir /g/data/xu18/ga --env /g/data/v10/Landsat-Collection-3-ops/OFFICIAL/Collection-3_5.4.1.env --workers 30 --nodes 34 --memory 192 --jobfs 50 --project v10 --queue normal --walltime 5:00:00
