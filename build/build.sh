#!/bin/bash
set -e
export SPACK_ROOT=$(readlink -f ../spack)
source ${SPACK_ROOT}/share/spack/setup-env.sh
nice make -j4
