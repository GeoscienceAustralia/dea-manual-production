#!/usr/bin/env python3

from logging.config import fileConfig
from dass_logs import LOGGER, LogMainFunction
from pathlib import Path
import pprint
import time
import psycopg2
from psycopg2 import sql
from collections import OrderedDict
from datetime import datetime

import datacube

# Logging
THIS_TASK = "monitor_ls9_reprocessing"
LOG_CONFIG_FILE = "log_config.ini"
timestr = time.strftime("_%Y%m%d_%H%M%S")
GEN_LOG_FILE = THIS_TASK + timestr + ".log"
log_config = Path(__file__).parent.joinpath(LOG_CONFIG_FILE).resolve()
logdir = Path(__file__).parent.resolve()

dc = datacube.Datacube(app=THIS_TASK)


def landsat_dates(product_id):
    # Extract date string from the product ID
    split_prod_id = product_id.split("_")
    acquisition_date_str = split_prod_id[3][0:8]
    processing_date_str = split_prod_id[4][0:8]
    return acquisition_date_str, processing_date_str


def log_initialise():
    # Logging
    gen_log_file = logdir.joinpath(GEN_LOG_FILE).resolve()
    fileConfig(
    log_config,
    disable_existing_loggers=False,
    defaults={"genlogfilename": str(gen_log_file)},
    )
    LOGGER.info(THIS_TASK, test='working')

def count_old_scenes(product, before_processing_date="20230307"):
    """
    Count the number of scenes that were USGS processed before the given date.
    """
    count = 0
    for tmp_dataset in dc.index.datasets.search_returning(("id",), product=product):
        dataset = dc.index.datasets.get(tmp_dataset.id, include_sources=False)
        landsat_product_id = dataset.metadata_doc['properties']['landsat:landsat_product_id']
        _, processing_date = landsat_dates(landsat_product_id)
        if processing_date < before_processing_date:
            count += 1
    return count, "old_count"


def get_pg_connection(host="dea-db.nci.org.au", dbname="datacube"):
    conn = psycopg2.connect(host=host, dbname=dbname)
    return conn


def active_count_before_date(product, before_datetime='2023-02-16'):
    """
    Give a count for a given product,
    that has not been archived before a date.
    """
    if 'ard' in product:
        datetime = 'dtr:end_datetime'
    else:
        datetime = 'datetime'
    conn = get_pg_connection()
    cur = conn.cursor()
    cur.execute(
        """
        SELECT count(*)
        FROM agdc.dataset
        WHERE dataset_type_ref = (
        SELECT id
        FROM agdc.dataset_type
        WHERE name = %(product)s
        )
        AND archived IS NULL
        AND metadata->'properties'->>%(datetime)s < %(before_datetime)s;
        """,
        {"product": product, "before_datetime":before_datetime, "datetime":datetime}
    )
    count = cur.fetchone()[0]
    cur.close()
    return count, "count"


def main():
    log_initialise()

    to_log = OrderedDict()
    before_processing_date="20230307"
    before_acq_datetime = '2023-02-23'

    product = "ga_ls9c_ard_3"
    for product in [["usgs_ls9c_level1_2", "l1"], ["ga_ls9c_ard_3", "ard"]]:
        count, tag = count_old_scenes(product[0], before_processing_date=before_processing_date)
        to_log[product[1] + "_" + tag] = count

        count, tag = active_count_before_date(product[0], before_datetime=before_acq_datetime)
        to_log[product[1] + "_" + tag] = count

    # Build info that can be cut and pasted into excel
    date_tag = datetime.today().strftime('%Y-%m-%d')
    delim = ' '
    print (to_log)
    a_key = 'date' + delim + (delim).join(to_log.keys())
    a_val = date_tag + delim + (delim).join(map(str, to_log.values()))
    to_log[a_key] = a_val
    LOGGER.info('ls9 stats', **to_log)

if __name__ == "__main__":
    main()