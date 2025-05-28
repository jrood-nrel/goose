#!/bin/bash -l
set -e
module purge || true
export SPACK_USER_CONFIG_PATH=${PWD}/.spack
export SPACK_USER_CACHE_PATH=${PWD}/.spack
export GOOSE_ROOT=$(readlink -f ../)
export SPACK_ROOT=$(readlink -f ../spack)
source ${SPACK_ROOT}/share/spack/setup-env.sh
spack env create software ${GOOSE_ROOT}/configs/darwin/spack.yaml
spack env activate software
spack concretize -f
time nice spack install
