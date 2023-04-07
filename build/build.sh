#!/bin/bash
set -e
export GOOSE_ROOT=$(readlink -f ../)
export SPACK_ROOT=$(readlink -f ../spack)
source ${SPACK_ROOT}/share/spack/setup-env.sh
cp ${HOME}/save/intel/license.lic ${SPACK_ROOT}/etc/spack/licenses/intel/
nice make -j4
