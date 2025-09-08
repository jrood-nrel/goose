#!/bin/bash -l
set -e
module purge || true
export GOOSE_ROOT=$(readlink -f ../)
export SPACK_ROOT=$(readlink -f ../spack)
source ${SPACK_ROOT}/share/spack/setup-env.sh
sed -i 's/timeout=60/timeout=7200/' ${SPACK_ROOT}/lib/spack/spack/stage.py || true
spack clean -mps
make clean
time nice make -j
