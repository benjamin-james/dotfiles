#!/bin/sh
if hostname -d | grep -Fwq "csail.mit.edu"; then
    MY_HOST="csail"
    DATA_DIR="/data/scratch/benjames/"
    MY_CONDA_DIR="${DATA_DIR}/miniconda3/"
fi
