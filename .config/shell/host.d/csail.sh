#!/bin/sh
if hostname -d 2>&1 | grep -Fwq "csail.mit.edu"; then
    export MY_HOST="csail"
    export DATA_DIR="/data/scratch/benjames/"
    export MY_CONDA_DIR="${DATA_DIR}/miniconda3/"
    export UV_CACHE_DIR="${DATA_DIR}/uv-cache"
    export XDG_CACHE_HOME="${DATA_DIR}/.cache"
fi
