GOOSE: Generator of Optimal Software Environments
-------------------------------------------------

This project seeks to generate software environments in scientific computing with the utmost of automation by utilizing makefiles which orchestrate multiple dependent phases of configuring and building Spack environments.

Use
~~~

cd build && DATE=$(date +"%Y-%m") make -j8

Acknowledgement
~~~~~~~~~~~~~~~
Work done under this project using makefiles to automate generation of software environments using Spack is based upon ideas and techniques developed by Harmen Stoppels from the `Spack project <https://spack.io>`_, as well as Phil Sakievich from Sandia National Laboratories who is the author of the `Spack Manager project <https://github.com/sandialabs/spack-manager>`_.
