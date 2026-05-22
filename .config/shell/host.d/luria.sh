
if hostname -s | grep -qE '^[bc][0-9]+$'; then
    export MY_HOST="luria"
fi
if hostname -s | grep -Fwq "luria"; then
    export MY_HOST="luria"
fi

if [ "$MY_HOST" = "luria" ]; then
    export DATA_DIR="/net/bmc-lab5/data/kellis/users/${USER}/"
    export DATA_GROUP_DIR="/net/bmc-lab5/data/kellis/group/"
    export SHARE_DIR="${DATA_GROUP_DIR}/Benjamin/"
    export MY_CONDA_PREFIX="/net/bmc-lab5/data/kellis/group/Benjamin/software/miniconda3"
fi
