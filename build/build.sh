#!/bin/bash
set -e
export GOOSE_ROOT=$(readlink -f ../)
export SPACK_ROOT=$(readlink -f ../spack)
source ${SPACK_ROOT}/share/spack/setup-env.sh
if [ "${NREL_CLUSTER}" == 'eagle' ] || [ "${NREL_CLUSTER}" == 'rhodes' ]; then
  mkdir -p ${SPACK_ROOT}/etc/spack/licenses/intel
  cp ${HOME}/save/intel/license.lic ${SPACK_ROOT}/etc/spack/licenses/intel/
fi
nice make -j
