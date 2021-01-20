#!/usr/bin/env python3

"""

"""

import json
import os

log_file = '/g/data/u46/users/dsg547/sandpit/processingDEA/ls_c3_ard_testing/NOA-171/grep_ancill_dass_2021-01-20.txt'

ls8_l1_path = []
ls8_l1_uuid = []
with open(log_file) as f:
    for line in f:
        line_dict = json.loads(line)
        #print (line_dict)
        ls8_l1_uuid.append(line_dict["dataset_id"]) 
        ls8_l1_path.append(os.path.splitext(line_dict["dataset_path"])[0] + ".odc-metadata.yaml") 
print (ls8_l1_uuid)

if True:
    f_out = open("bad_l1_uuids_to_archive.txt", "w")
    for a_uuid in ls8_l1_uuid:
        f_out.write(str(a_uuid) + '\n')
    f_out.close()

    f_out = open("test_db_path.txt", "w")
    for a_path in ls8_l1_path:
        f_out.write(str(a_path) + '\n')
    f_out.close()

