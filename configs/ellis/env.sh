#!/bin/bash

export NREL_CLUSTER=ellis
export TMPDIR=/data/ssd1/home/${USER}/.tmp
mkdir -p ${TMPDIR}
umask u=rwx,go=rx,o=rx

MODULES_DATE=2024-05-01
export MODULE_PREFIX=/data/ssd1/software/${MODULES_DATE}/opt/bootstrap/linux-rocky8-zen/gcc-12.3.0/environment-modules-5.4.0-2qlekdmdckr22bzur3c36gmik7txolkc
export PATH=${MODULE_PREFIX}/bin:${PATH}
module() { eval $(${MODULE_PREFIX}/bin/modulecmd $(basename ${SHELL}) $*); }

module purge
module unuse ${MODULEPATH}
module use /data/ssd1/software/${MODULES_DATE}/modules/compilers/linux-rocky8-zen2/gcc-12.3.0
module use /data/ssd1/software/${MODULES_DATE}/modules/software/linux-rocky8-zen2/gcc-13.2.0
