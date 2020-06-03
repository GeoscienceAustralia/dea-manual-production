
#!/bin/bash
#PBS -P v10
#PBS -W umask=017
#PBS -q normal
#PBS -l walltime=1:00:00,mem=155GB,other=pernodejobfs
#PBS -l wd
#PBS -l storage=gdata/v10+scratch/v10+gdata/if87+gdata/fj7+scratch/fj7+scratch/u46+gdata/u46+gdata/xu18+scratch/xu18
#PBS -l ncpus=1

source /g/data/v10/Landsat-Collection-3-ops/OFFICIAL/Collection-3_5.4.1.env
ard_pbs --level1-list /g/data/u46/users/dsg547/results/first1000ARD/unable_to_open_file.txt --workdir  /g/data/v10/projects/landsat_c3/wagl_workdir --logdir /g/data/v10/projects/landsat_c3/wagl_logdir --pkgdir /g/data/xu18/ga --env /g/data/v10/Landsat-Collection-3-ops/OFFICIAL/Collection-3_5.4.1.env --workers 30 --nodes 1 --memory 192 --jobfs 50 --project v10 --queue normal --walltime 10:00:00
