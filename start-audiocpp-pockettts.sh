#!/bin/bash
set -euo pipefail

cd /home/dwemer/audio.cpp

if [ -f "/home/dwemer/.cuda_config" ]; then
    source /home/dwemer/.cuda_config
fi

if [ -d "/usr/local/cuda-12.8" ]; then
    export CUDA_HOME="/usr/local/cuda-12.8"
elif [ -d "/usr/local/cuda-13.0" ]; then
    export CUDA_HOME="/usr/local/cuda-13.0"
elif [ -d "/usr/local/cuda" ]; then
    export CUDA_HOME="/usr/local/cuda"
fi

if [ -n "${CUDA_HOME:-}" ]; then
    export PATH="$CUDA_HOME/bin:$PATH"
fi

export LD_LIBRARY_PATH="/usr/lib/wsl/lib:${CUDA_HOME:-/usr/local/cuda}/targets/x86_64-linux/lib:${LD_LIBRARY_PATH:-}"

mkdir -p speakers
build/bin/audiocpp_server --config server.json >> server.log 2>&1 &
