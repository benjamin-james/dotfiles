
if hostname -s | grep -qE '^[bc][0-9]+$'; then
    MY_HOST="luria"
fi
if hostname -s | grep -Fwq "luria"; then
    MY_HOST="luria"
    alias tmux="$HOME/bin/tmux"
fi

if [ "$MY_HOST" = "luria" ]; then
    DATA_DIR="/net/bmc-lab5/data/kellis/users/${USER}/"
    DATA_GROUP_DIR="/net/bmc-lab5/data/kellis/group/"
    SHARE_DIR="${DATA_GROUP_DIR}/Benjamin/"
    MY_CONDA_PREFIX="/net/bmc-lab5/data/kellis/group/Benjamin/software/miniconda3"
fi
