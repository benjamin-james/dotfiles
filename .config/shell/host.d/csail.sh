#!/bin/sh
if [ "$HOME" = "/afs/csail.mit.edu/u/b/$USER" ]; then
	export MY_HOST="csail"
	export DATA_DIR="/data/scratch/$USER/"
	export MY_CONDA_DIR="${DATA_DIR}/miniconda3/"
	export UV_CACHE_DIR="${DATA_DIR}/uv-cache"
	export XDG_CACHE_HOME="${DATA_DIR}/.cache"
fi
