#!/bin/sh
if hostname -d 2>&1 | grep -Fwq "broadinstitute.org"; then
    export MY_HOST="broad"
    export DATA_DIR="/broad/compbio_ce/${USER}/data"
    export REF_DIR="${DATA_DIR}/ref/"
    export MY_CONDA_DIR="${DATA_DIR}/miniconda3"
fi
