#!/bin/bash

export NREL_CLUSTER=ellis

export MODULE_PREFIX=/data/ssd1/software/2022-11-28/opt/bootstrap/linux-rocky8-zen/gcc-8.5.0/environment-modules-5.2.0-6q2w5qvdl4jzhod5uava5qr3c6d2fpel
export PATH=${MODULE_PREFIX}/bin:${PATH}
module() { eval $(${MODULE_PREFIX}/bin/modulecmd $(basename ${SHELL}) $*); }

MODULES_DATE=2022-11-28
module purge
module unuse ${MODULEPATH}
module use /data/ssd1/software/${MODULES_DATE}/modules/compilers/linux-rocky8-zen/gcc-8.5.0
module use /data/ssd1/software/${MODULES_DATE}/modules/packages/linux-rocky8-zen2/gcc-10.4.0
