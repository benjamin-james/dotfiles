#!/bin/sh
if hostname -d 2>&1 | grep -Fwq "broadinstitute.org"; then
    MY_HOST="broad"
    DATA_DIR="/broad/compbio_ce/${USER}/data"
    REF_DIR="${DATA_DIR}/ref/"
    MY_CONDA_DIR="${DATA_DIR}/miniconda3"
fi
