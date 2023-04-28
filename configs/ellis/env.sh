#!/bin/bash

export NREL_CLUSTER=ellis

MODULES_DATE=2023-03
export MODULE_PREFIX=/data/ssd1/software/${MODULES_DATE}/opt/bootstrap/linux-rocky8-zen/gcc-10.4.0/environment-modules-5.2.0-2joscpkp3qvte32ggyimdtjcoa2rceve
export PATH=${MODULE_PREFIX}/bin:${PATH}
module() { eval $(${MODULE_PREFIX}/bin/modulecmd $(basename ${SHELL}) $*); }

module purge
module unuse ${MODULEPATH}
module use /data/ssd1/software/${MODULES_DATE}/modules/compilers/linux-rocky8-zen/gcc-10.4.0
module use /data/ssd1/software/${MODULES_DATE}/modules/software/linux-rocky8-zen2/gcc-10.4.0
