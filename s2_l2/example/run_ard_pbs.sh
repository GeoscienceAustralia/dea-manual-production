#!/bin/bash

# Produce an example ARD scene
# modify s2-granules-subset.txt
# to select the scene or scenes to process

loc=$PWD

LOGDIR=$loc/logdir
WORKDIR=$loc/workdir
ENV=$loc/definitive.env

source  $ENV
mkdir -p $LOGDIR
mkdir -p $WORKDIR

ard_pbs --level1-list s2-granules-subset.txt \
    --workdir $WORKDIR \
    --logdir $LOGDIR \
    --pkgdir  $WORKDIR \
    --env  $ENV \
    --workers 3 \
    --nodes 1 \
    --memory 192 \
    --jobfs 50 \
    --project u46 \
    --queue normal \
    --walltime 03:00:00
