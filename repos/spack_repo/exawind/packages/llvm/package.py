import os
from spack.package import *
from spack_repo.builtin.packages.llvm.package import Llvm as bLlvm


class Llvm(bLlvm):
     patch("lldb_python_exe_relative_path.patch", when="@16:+lldb+python")
