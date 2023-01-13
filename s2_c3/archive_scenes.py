#!/usr/bin/env python3

"""
This is being tested in
https://bitbucket.org/geoscienceaustralia/ard_pipeline_support/src/main/tickets/DSNS-71/
and there is a copy of this code in
https://bitbucket.org/geoscienceaustralia/ard_pipeline_support/
This is an interim solution until a module is created.

This script is to archive s2 c3 l1s based on a list of zip files.


"""
import sys
from datacube import Datacube
import yaml
import glob
import os
import shutil
from pathlib import Path
import click


def run(scene_dirs_file: Path, config_file: Path, archive):
    dc = Datacube(config=config_file)
    
    #print (dc.list_products())

    #print(scene_dirs_file)
    with open(scene_dirs_file) as f:
        for line in f.readlines():
            #print (line)
            line = line.strip()

            # for S2
            loc = f'zip:{line}!/'
            dss = dc.index.datasets.get_datasets_for_location(loc, mode='prefix')
            for ds in dss:
                print(f'{ds.id} - {line}')
                if archive:
                    dc.index.datasets.archive([ds.id])



@click.command()
@click.option(
    "--scene-dirs-file",
    help="Location of a file with each line being a scene directory location.",
    default=None,
    type=click.Path(exists=True),
)
@click.option(
    "--config-file",
    type=click.Path(exists=True),
    default=None,
)
@click.option(
    "--archive",
    is_flag=True,
    show_default=True,
    default=False,
    help="Delete un-indexed directories."
)

def cli(scene_dirs_file: Path,
config_file: Path,
archive):

    run(scene_dirs_file=scene_dirs_file,
    config_file=config_file,
    archive=archive)
    sys.exit(0)

if __name__ == "__main__":
    cli()                   
