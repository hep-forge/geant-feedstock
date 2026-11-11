#!/bin/bash
set -eo pipefail

# Build with the C++ standard ROOT was built with (as vmc does).
CXXSTD=$(root-config --cflags | grep -o 'std=c++[0-9a-z]*' | sed 's/std=c++//')

# Geant3 is Fortran 77 written for g77: newer gfortran rejects its
# argument-type mismatches unless told to allow them.
export FFLAGS="${FFLAGS} -fallow-argument-mismatch -fallow-invalid-boz -std=legacy"
# Its C (minicern) is K&R style: "int f()" declarations called with
# arguments, which C23 (GCC 15+'s default) reads as "takes none".
export CFLAGS="${CFLAGS} -std=gnu17"

cmake ${CMAKE_ARGS} -S "${SRC_DIR}" -B build \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_CXX_STANDARD="${CXXSTD}" \
    -DCMAKE_Fortran_FLAGS="${FFLAGS}" \
    -DCMAKE_C_FLAGS="${CFLAGS}"
cmake --build build --parallel "${CPU_COUNT}" --target install
