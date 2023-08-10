from spack.package import *
from spack.pkg.builtin.intel_parallel_studio import IntelParallelStudio as bIntelParallelStudio

class IntelParallelStudio(bIntelParallelStudio):
    # Avoid error /lib64/libstdc++.so.6: version `CXXABI_1.3.9'
    # not found (required by ./libplatform_picker_AXE_install.so)
    depends_on("gcc@8:", type="build")
