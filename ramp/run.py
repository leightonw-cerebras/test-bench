#!/usr/bin/env cs_python

import argparse
import csv
import json
import numpy as np

from cerebras.sdk.runtime.sdkruntimepybind import SdkRuntime, MemcpyDataType, MemcpyOrder
from cerebras.sdk import sdk_utils

# Read arguments
parser = argparse.ArgumentParser()
parser.add_argument('--name', help="the test compile output dir")
parser.add_argument('--cmaddr', help="IP:port for CS system")
args = parser.parse_args()

# Get matrix dimensions from compile metadata
with open(f"{args.name}/out.json", encoding='utf-8') as json_file:
  compile_data = json.load(json_file)

# Matrix dimensions
M = int(compile_data['params']['M'])

# Construct x
x = np.full(shape=M, fill_value=1.0, dtype=np.float32)

# Construct a runner using SdkRuntime
runner = SdkRuntime(args.name, cmaddr=args.cmaddr)

# Get symbols on device
x_symbol = runner.get_id('x')
y_symbol = runner.get_id('y')
timer_buf_symbol = runner.get_id('timer_buf')

# Load and run the program
runner.load()
runner.run()

# Launch the compute function on device
runner.launch('launch', nonblock=False)

# Copy time back
time_result = np.zeros((3), dtype=np.float32)
runner.memcpy_d2h(time_result, timer_buf_symbol, 0, 0, 1, 1, 3,
    streaming=False, data_type=MemcpyDataType.MEMCPY_32BIT, order=MemcpyOrder.ROW_MAJOR, nonblock=False)

# Stop the program
runner.stop()

num_cycles = sdk_utils.calculate_cycles(time_result)
num_cycles_per_M = num_cycles / M

print("M: ", M, ", num_cycles: ", num_cycles, ", num_cycles_per_M: ", num_cycles_per_M)

# Write a CSV
if args.cmaddr:
    csv_name = "out_cs2.csv"
else:
    csv_name = "out_sim.csv"

with open(csv_name, mode='a') as csv_file:
    csv_writer = csv.writer(csv_file)
    csv_writer.writerow([M, num_cycles, num_cycles_per_M])
