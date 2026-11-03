#!/usr/bin/env bash
set -eux

# Look in the conda prefix first: on macOS CMake otherwise finds the SDK's
# expat (2.2.5), older than Geant4's 2.9.0 minimum.
cmake -DCMAKE_PREFIX_PATH="${PREFIX}" -DCMAKE_FIND_FRAMEWORK=LAST "${PREFIX}/share/Geant4/examples/basic/B1"
make
./exampleB1 run2.mac
