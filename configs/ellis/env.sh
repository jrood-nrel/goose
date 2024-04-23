#!/bin/bash

export NREL_CLUSTER=ellis
export TMPDIR=/data/ssd1/home/${USER}/.tmp
mkdir -p ${TMPDIR}
umask u=rwx,go=rx,o=rx

MODULES_DATE=2023-05-11
export MODULE_PREFIX=/data/ssd1/software/${MODULES_DATE}/opt/bootstrap/linux-rocky8-zen/gcc-8.5.0/environment-modules-5.2.0-2joscpkp3qvte32ggyimdtjcoa2rceve
export PATH=${MODULE_PREFIX}/bin:${PATH}
module() { eval $(${MODULE_PREFIX}/bin/modulecmd $(basename ${SHELL}) $*); }

module purge
module unuse ${MODULEPATH}
module use /data/ssd1/software/${MODULES_DATE}/modules/compilers/linux-rocky8-zen2/gcc-10.4.0
module use /data/ssd1/software/${MODULES_DATE}/modules/software/linux-rocky8-zen2/gcc-10.4.0
