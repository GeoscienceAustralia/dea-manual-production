#!/usr/bin/env bash
set -e


if [[ $HOSTNAME == *"gadi"* ]]; then
  echo "gadi - NCI"
  module use /g/data/v10/public/modules/modulefiles
  module use /g/data/v10/private/modules/modulefiles

  module load dea
  
else
  echo "not NCI"
fi

ODCCONF=""

datacube $ODCCONF system check


# Defining S2 l1's
#datacube metadata add eo3_sentinel.odc-type.yaml
#datacube $ODCCONF product add l1_s2a.odc-product.yaml
datacube $ODCCONF product add l1_s2b.odc-product.yaml

# Defining S2 ard's
datacube $ODCCONF metadata add eo3_sentinel_ard.odc-type.yaml
datacube $ODCCONF product add ard_s2a.odc-product.yaml
datacube $ODCCONF product add ard_s2b.odc-product.yaml
