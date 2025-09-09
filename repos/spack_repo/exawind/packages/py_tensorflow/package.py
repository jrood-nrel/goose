import os
from spack.package import *
from spack_repo.builtin.packages.py_tensorflow.package import PyTensorflow as bPyTensorflow


class PyTensorflow(bPyTensorflow):
    depends_on("binutils", type="link")
