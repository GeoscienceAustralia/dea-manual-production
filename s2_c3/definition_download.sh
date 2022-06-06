#!/usr/bin/env bash

# lpgs was timing out so I'm downloading these files

# Defining S2 l1's
wget https://raw.githubusercontent.com/GeoscienceAustralia/digitalearthau/develop/digitalearthau/config/eo3/eo3_sentinel.odc-type.yaml
wget https://raw.githubusercontent.com/GeoscienceAustralia/digitalearthau/develop/digitalearthau/config/eo3/products/l1_s2a.odc-product.yaml
wget https://raw.githubusercontent.com/GeoscienceAustralia/digitalearthau/develop/digitalearthau/config/eo3/products/l1_s2b.odc-product.yaml

# Defining S2 ard's
wget add https://raw.githubusercontent.com/GeoscienceAustralia/digitalearthau/develop/digitalearthau/config/eo3/eo3_sentinel_ard.odc-type.yaml
wget add https://raw.githubusercontent.com/GeoscienceAustralia/digitalearthau/develop/digitalearthau/config/eo3/products/ard_s2a.odc-product.yaml
wget add https://raw.githubusercontent.com/GeoscienceAustralia/digitalearthau/develop/digitalearthau/config/eo3/products/ard_s2b.odc-product.yaml
