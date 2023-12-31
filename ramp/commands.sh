#!/usr/bin/env bash

set -e

cslc ./layout.csl --fabric-dims=11,3 \
--fabric-offsets=4,1 --params=M:1000 -o out --memcpy --channels 1
cs_python run.py --name out
