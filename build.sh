#!/bin/bash

# Exit if any command fails
set -e

# Output simulation executable
OUTPUT=sim.out

# Source folders
SRC_DIR=$(pwd)/code
COMP_DIR=$(pwd)/code/components

# Find all .v files in the directories
CODE_FILES=$(find $SRC_DIR -maxdepth 1 -name "*.v")
COMP_FILES=$(find $COMP_DIR -name "*.v")

# Combine all Verilog files
ALL_FILES="$CODE_FILES $COMP_FILES tb.v"

# Compile all Verilog files
iverilog -o $OUTPUT $ALL_FILES 

# Copy the memory file into the current directory before running
cp $(pwd)/code/program.hex .

# Run the simulation
vvp $OUTPUT

# Open waveform if available
if [ -f dump.vcd ]; then
    echo "Opening waveform with GTKWave..."
    gtkwave dump.vcd &
fi
