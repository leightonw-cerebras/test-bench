#!/usr/bin/env bash

set -e

cslc ./layout.csl --fabric-dims=757,996 \
--fabric-offsets=4,1 --params=M:1000 -o out --memcpy --channels 1
cs_python run.py --name out --cmaddr $CS_IP_ADDR
