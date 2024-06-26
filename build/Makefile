DATE = 2024-06-10
INSTALLDIR = /no/where
COMPILERS = llvm gcc

ifeq ($(NREL_CLUSTER),eagle)
  #INSTALLDIR = /nopt/nrel/ecom/hpacf/$(DATE)
  INSTALLDIR = /scratch/jrood/nrel/ecom/hpacf/$(DATE)
endif

ifeq ($(NREL_CLUSTER),ellis)
  INSTALLDIR = /data/ssd1/software/$(DATE)
endif

export SPACK_USER_CONFIG_PATH=$(CURDIR)/.spack
export SPACK_USER_CACHE_PATH=$(CURDIR)/.spack
unexport SPACK_DISABLE_LOCAL_CONFIG

.SUFFIXES:

.PHONY: all clean

all: software/generated/modules

clean:
	rm -rf bootstrap/
	rm -rf compilers/
	rm -rf software/
	rm -rf .spack/

# Bootstrap
bootstrap/spack.yaml:
	mkdir -p bootstrap
	cp $(GOOSE_ROOT)/configs/$(NREL_CLUSTER)/bootstrap_env.yaml bootstrap/spack.yaml

bootstrap/compilers.yaml:
	SPACK_USER_CONFIG_PATH=bootstrap spack compiler find --scope=user

bootstrap/config.yaml:
	SPACK_USER_CONFIG_PATH=bootstrap spack config --scope=user add config:install_tree:root:$(INSTALLDIR)/opt/bootstrap
	SPACK_USER_CONFIG_PATH=bootstrap spack config --scope=user add modules:default:roots:tcl:$(INSTALLDIR)/modules/bootstrap

bootstrap/packages.yaml:
	touch bootstrap/packages.yaml
	#SPACK_USER_CONFIG_PATH=bootstrap spack external find --scope=user $(external_packages)

bootstrap/spack.lock: bootstrap/spack.yaml bootstrap/config.yaml bootstrap/packages.yaml bootstrap/compilers.yaml
	SPACK_USER_CONFIG_PATH=bootstrap spack -e bootstrap concretize --force

bootstrap/spack.mk: bootstrap/spack.lock
	SPACK_USER_CONFIG_PATH=bootstrap spack -e bootstrap env depfile --make-target-prefix bootstrap/generated -o $@

bootstrap/generated/modules: bootstrap/generated/env
	SPACK_USER_CONFIG_PATH=bootstrap spack -e bootstrap module tcl refresh -y
	touch bootstrap/generated/modules

# Compilers
compilers/spack.yaml:
	mkdir -p compilers
	cp $(GOOSE_ROOT)/configs/$(NREL_CLUSTER)/compilers_env.yaml compilers/spack.yaml

compilers/compilers.yaml: bootstrap/generated/modules
	SPACK_USER_CONFIG_PATH=compilers spack compiler find --scope=user $$(spack -e bootstrap find --format '{prefix}' gcc)
	export BINUTILS_PATH=$$(SPACK_USER_CONFIG_PATH=bootstrap spack -e bootstrap location -i --first binutils)/bin; \
	sed -i -e "s|environment: {}|environment:\n      prepend_path:\n        PATH: $${BINUTILS_PATH}|g" compilers/compilers.yaml

compilers/config.yaml: 
	SPACK_USER_CONFIG_PATH=compilers spack config --scope=user add config:install_tree:root:$(INSTALLDIR)/opt/compilers
	SPACK_USER_CONFIG_PATH=compilers spack config --scope=user add modules:default:roots:tcl:$(INSTALLDIR)/modules/compilers

compilers/packages.yaml:
	touch compilers/packages.yaml
	#SPACK_USER_CONFIG_PATH=compilers spack external find --scope=user $(external_packages)

compilers/spack.lock: compilers/spack.yaml compilers/config.yaml compilers/packages.yaml compilers/compilers.yaml
	SPACK_USER_CONFIG_PATH=compilers spack -e compilers concretize --force

compilers/spack.mk: compilers/spack.lock
	SPACK_USER_CONFIG_PATH=compilers spack -e compilers env depfile --make-target-prefix compilers/generated -o $@

compilers/generated/modules: compilers/generated/env
	SPACK_USER_CONFIG_PATH=compilers spack -e compilers module tcl refresh -y
	touch compilers/generated/modules

# Software
software/spack.yaml:
	mkdir -p software
	cp $(GOOSE_ROOT)/configs/$(NREL_CLUSTER)/software_env.yaml software/spack.yaml

software/compilers.yaml: compilers/generated/modules
	# selectively pull compilers to avoid system gcc
	SPACK_USER_CONFIG_PATH=software spack compiler find --scope=user $$(spack -e compilers find --format '{prefix}' $(COMPILERS))
	SPACK_USER_CONFIG_PATH=software spack compiler find --scope=user $$(spack -e compilers find --format '{prefix}' intel-oneapi-compilers)/compiler/latest/linux/bin/intel64
	SPACK_USER_CONFIG_PATH=software spack compiler find --scope=user $$(spack -e compilers find --format '{prefix}' intel-oneapi-compilers)/compiler/latest/linux/bin
	export BINUTILS_PATH=$$(SPACK_USER_CONFIG_PATH=bootstrap spack -e bootstrap location -i --first binutils)/bin; \
	export GCC_BINPATH=$$(SPACK_USER_CONFIG_PATH=bootstrap spack -e bootstrap find --format '{prefix}' gcc)/bin; \
	export GCC_LIBPATH=$$(SPACK_USER_CONFIG_PATH=bootstrap spack -e bootstrap find --format '{prefix}' gcc)/lib64; \
	sed -i -e "s|environment: {}|environment:\n      prepend_path:\n        PATH: $${BINUTILS_PATH}|g" software/compilers.yaml; \
	sed -i -e '/oneapi@=/,/- compiler:/!b' -e "s|        PATH:.*|        PATH: $${GCC_BINPATH}:$${BINUTILS_PATH}|g" software/compilers.yaml; \
	sed -i -e '/dpcpp@=/,/- compiler:/!b' -e "s|        PATH:.*|        PATH: $${GCC_BINPATH}:$${BINUTILS_PATH}|g" software/compilers.yaml; \
	sed -i -e '/oneapi@=/,/- compiler:/!b' -e "s|extra_rpaths: \[\]|extra_rpaths:\n       - $${GCC_LIBPATH}|g" software/compilers.yaml; \
	sed -i -e '/dpcpp@=/,/- compiler:/!b' -e "s|extra_rpaths: \[\]|extra_rpaths:\n       - $${GCC_LIBPATH}|g" software/compilers.yaml

software/config.yaml:
	SPACK_USER_CONFIG_PATH=software spack config --scope=user add config:install_tree:root:$(INSTALLDIR)/opt/software
	SPACK_USER_CONFIG_PATH=software spack config --scope=user add modules:default:roots:tcl:$(INSTALLDIR)/modules/software

software/packages.yaml:
	touch software/packages.yaml
	#SPACK_USER_CONFIG_PATH=software spack external find --scope=user $(external_packages)

software/spack.lock: software/spack.yaml software/config.yaml software/packages.yaml software/compilers.yaml
	SPACK_USER_CONFIG_PATH=software spack python $(GOOSE_ROOT)/utilities/mixed_compiler_creator.py software/compilers.yaml
	export PATH=$$(SPACK_USER_CONFIG_PATH=bootstrap spack -e bootstrap location -i --first binutils)/bin:$${PATH}; \
	SPACK_USER_CONFIG_PATH=software spack -e software concretize --force

software/spack.mk: software/spack.lock
	SPACK_USER_CONFIG_PATH=software spack -e software env depfile --make-target-prefix software/generated -o $@

software/generated/modules: software/generated/env
	SPACK_USER_CONFIG_PATH=software spack -e software module tcl refresh -y
	chmod -R a+rX,go-w $(INSTALLDIR)
	touch software/generated/modules

ifeq (,$(filter clean,$(MAKECMDGOALS)))
include bootstrap/spack.mk

ifneq (,$(wildcard bootstrap/spack.mk))
include compilers/spack.mk
endif

ifneq (,$(wildcard compilers/spack.mk))
include software/spack.mk
endif

endif
