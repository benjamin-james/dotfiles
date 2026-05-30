#!/bin/sh

if [ -z "${MY_CONDA_PREFIX:-}" ]; then
    for pfx in "$HOME/.local/share/miniconda3" "$HOME/.local/share/anaconda3"; do
	if [ -d "${pfx}" ]; then
	    MY_CONDA_PREFIX="$pfx"
	    export MY_CONDA_PREFIX
	    break
	fi
    done
fi
