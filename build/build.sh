#!/bin/bash
set -e
module purge || true
export GOOSE_ROOT=$(readlink -f ../)
export SPACK_ROOT=$(readlink -f ../spack)
source ${SPACK_ROOT}/share/spack/setup-env.sh
time nice make -j
