# Copyright Spack Project Developers. See COPYRIGHT file for details.
#
# SPDX-License-Identifier: (Apache-2.0 OR MIT)

from spack_repo.builtin.build_systems.python import PythonPackage

from spack.package import *


class PyLlvmlite(PythonPackage):
    """A lightweight LLVM python binding for writing JIT compilers"""

    homepage = "https://llvmlite.readthedocs.io/en/latest/index.html"
    pypi = "llvmlite/llvmlite-0.23.0.tar.gz"
    git = "https://github.com/numba/llvmlite.git"

    license("BSD-2-Clause")

    version("0.44.0", sha256="07667d66a5d150abed9157ab6c0b9393c9356f229784a4385c02f99e94fc94d4")
    version("0.43.0", sha256="ae2b5b5c3ef67354824fb75517c8db5fbe93bc02cd9671f3c62271626bc041d5")
    version("0.42.0", sha256="f92b09243c0cc3f457da8b983f67bd8e1295d0f5b3746c7a1861d7a99403854a")
    version("0.41.1", sha256="f19f767a018e6ec89608e1f6b13348fa2fcde657151137cb64e56d48598a92db")
    version("0.41.0", sha256="7d41db345d76d2dfa31871178ce0d8e9fd8aa015aa1b7d4dab84b5cb393901e0")
    version("0.40.1", sha256="5cdb0d45df602099d833d50bd9e81353a5e036242d3c003c5b294fc61d1986b4")
    version("0.40.0", sha256="c910b8fbfd67b8e9d0b10ebc012b23cd67cbecef1b96f00d391ddd298d71671c")
    version("0.39.1", sha256="b43abd7c82e805261c425d50335be9a6c4f84264e34d6d6e475207300005d572")
    version("0.39.0", sha256="01098be54f1aa25e391cebba8ea71cd1533f8cd1f50e34c7dd7540c2560a93af")
    version("0.38.1", sha256="0622a86301fcf81cc50d7ed5b4bebe992c030580d413a8443b328ed4f4d82561")
    version("0.38.0", sha256="a99d166ccf3b116f3b9ed23b9b70ba2415640a9c978f3aaa13fad49c58f4965c")
    version("0.37.0", sha256="6392b870cd018ec0c645d6bbb918d6aa0eeca8c62674baaee30862d6b6865b15")

    depends_on("cxx", type="build")  # generated

    depends_on("py-setuptools", type="build")
    depends_on("python@3.10:3.13", when="@0.44:", type=("build", "run"))
    depends_on("python@3.9:3.12", when="@0.42:0.43", type=("build", "run"))
    depends_on("python@3.8:3.11", when="@0.40:0.41", type=("build", "run"))
    depends_on("python@:3.10", when="@0.38:0.39", type=("build", "run"))
    depends_on("python@:3.9", when="@0.36:0.37", type=("build", "run"))

    # https://github.com/numba/llvmlite#compatibility
    depends_on("llvm@15", when="@0.44:")
    depends_on("llvm@14", when="@0.41:0.43")
    depends_on("llvm@11:14", when="@0.40")
    depends_on("llvm@11", when="@0.37:0.39")
    for t in [
        "arm:",
        "ppc:",
        "ppc64:",
        "ppc64le:",
        "ppcle:",
        "sparc:",
        "sparc64:",
        "x86:",
        "x86_64:",
    ]:
        depends_on("llvm@10.0", when=f"@0.34:0.36 target={t}")

    depends_on("binutils", type="build")
    depends_on("ncurses", type="link")

    # TODO: investigate
    conflicts("%apple-clang@15:")

    def setup_build_environment(self, env: EnvironmentModifications) -> None:
        if self.spec.satisfies("%fj"):
            env.set("CXX_FLTO_FLAGS", "{0}".format(self.compiler.cxx_pic_flag))
            env.set("LD_FLTO_FLAGS", "-Wl,--exclude-libs=ALL")
        else:
            # Need to set PIC flag since this is linking statically with LLVM
            env.set("CXX_FLTO_FLAGS", "-flto {0}".format(self.compiler.cxx_pic_flag))
