#!/usr/bin/env bash
#SBATCH -p kellis
#SBATCH -J jupyter
### Usage: 'sbatch jupyter_luria.sh envname' on host
### Usage: 'jupyter_luria.sh b4' on client
export JUPYTER_LURIA_PREFIX=${JUPYTER_LURIA_PREFIX:-"99"}
export JUPYTER_CMD=${JUPYTER_CMD:-"lab"}
export BENJ_CONDA_INIT="$HOME/src/conda_init.sh"
if hostname -s | grep -qE '^b[0-9]+$'; then
    ### we are on a compute node
    conda_env=${1:-${CONDA_DEFAULT_ENV}}
    PORT=$(hostname -s | tr -d 'b' | xargs printf "${JUPYTER_LURIA_PREFIX}%02d\n")
    echo "Activating Jupyter notebook on (${conda_env}) for port ${PORT} in dir $PWD"
    if [[ -f "${BENJ_CONDA_INIT}" ]]; then
	source "${BENJ_CONDA_INIT}"
    else
	echo "File \"${BENJ_CONDA_INIT}\" does not exist. Please initialize according to the readme https://github.com/kellislab/benj"
	exit 1
    fi
    conda activate ${conda_env}
    exec jupyter "${JUPYTER_CMD}" --no-browser --port=${PORT}
else
    PORT=$(echo $1 | tr -d 'b' | xargs printf "${JUPYTER_LURIA_PREFIX}%02d\n")
    echo "Connect to https://localhost:${PORT}/" to view.
    ssh ${ARGS} -N -L ${PORT}:localhost:${PORT} "$@"
fi
