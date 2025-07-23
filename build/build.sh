#!/bin/bash -l

cmd() {
  echo "+ $@"
  eval "$@"
}

if [[ "${NREL_CLUSTER}" == 'ellis' ]]; then
  cmd "export MY_MACHINE=ellis"
  cmd "module purge" || true
elif [[ "$(sw_vers --productName)" == 'macOS' ]]; then
  cmd "export MY_MACHINE=darwin"
fi

cmd "export SPACK_USER_CONFIG_PATH=${PWD}/.spack"
cmd "export SPACK_USER_CACHE_PATH=${PWD}/.spack"
cmd "export SPACK_DISABLE_LOCAL_CONFIG=true"
cmd "export GOOSE_ROOT=$(readlink -f ..)"
cmd "export SPACK_ROOT=${GOOSE_ROOT}/spack"

set -e
cmd "source ${SPACK_ROOT}/share/spack/setup-env.sh"
cmd "rm -rf ${SPACK_ROOT}/var/spack/environments/software"
cmd "spack env create software ${GOOSE_ROOT}/configs/${MY_MACHINE}/spack.yaml"
cmd "spack env activate software"
cmd "spack concretize -f"
cmd "time nice spack install"
cmd "spack module tcl refresh -y"
