
if hostname -s | grep -qE '^[bc][0-9]+$'; then
    MY_HOST="luria"
    MY_CONDA_PREFIX="/net/bmc-lab5/data/kellis/group/Benjamin/software/miniconda3"
fi
if hostname -s | grep -Fwq "luria"; then
    MY_HOST="luria"
    MY_CONDA_PREFIX="/net/bmc-lab5/data/kellis/group/Benjamin/software/miniconda3"
    alias tmux="$HOME/bin/tmux"
fi

