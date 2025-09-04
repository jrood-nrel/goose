import os
from spack.package import *
from spack_repo.builtin.packages.py_llvmlite.package import Pyllvmlite as bPyllvmlite


class Pyllvmlite(bPyllvmlite):
     depends_on("ncurses", type="link")
