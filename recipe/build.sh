#!/usr/bin/env bash
# Adapted from conda-forge's own geant4-feedstock build_geant4.sh (a
# proven, currently-passing recipe) -- deviations from it are limited to:
# name (geant, not geant4), source (this fork's commit), and
# CMAKE_CXX_STANDARD=20 (not 17, needed for downstream ACTS/DD4hep compat).
#
# GEANT4_USE_HDF5=OFF (conda-forge has it ON): Geant4's bundled g4tools
# HDF5 histogram/analysis-output wrapper (source/externals/g4tools) calls
# H5Dcreate2/H5Dopen2/etc. with a fixed, older arg count that doesn't
# match conda-forge's current hdf5 build's API mapping ("too few
# arguments" compile errors). Not in the originally requested EIC
# variant set (+opengl+qt+x11+threads-vecgeom-vtk never mentions hdf5)
# and not needed downstream by dd4hep either -- just drop it rather
# than chase HDF5's default-API-version compile defines.
set -eux

test -f "${SRC_DIR}/src/CMakeLists.txt"

mkdir geant4-build

cmake \
    -B ./geant4-build \
    -S "${SRC_DIR}/src" \
    ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_CXX_STANDARD=20 \
    -DGEANT4_BUILD_MULTITHREADED=ON \
    -DGEANT4_BUILD_TLS_MODEL=global-dynamic \
    -DGEANT4_INSTALL_DATA=OFF \
    -DGEANT4_INSTALL_DATADIR="${PREFIX}/share/Geant4/data" \
    -DGEANT4_INSTALL_EXAMPLES=ON \
    -DGEANT4_INSTALL_PACKAGE_CACHE=OFF \
    -DGEANT4_USE_FREETYPE=ON \
    -DGEANT4_USE_GDML=ON \
    -DGEANT4_USE_QT=ON \
    -DGEANT4_USE_HDF5=OFF \
    -DGEANT4_USE_SYSTEM_CLHEP=ON \
    -DGEANT4_USE_SYSTEM_EXPAT=ON \
    -DGEANT4_USE_SYSTEM_ZLIB=ON \
    -DGEANT4_USE_OPENGL_X11=ON \
    -DGEANT4_USE_RAYTRACER_X11=ON \
    -DQT_QMAKE_EXECUTABLE="${PREFIX}/bin/qmake6"

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
cmake --build ./geant4-build --config Release --parallel "${NPROC}"
cmake --install ./geant4-build

# geant4.sh/geant4.csh assume a non-conda install layout and aren't
# needed -- conda's own activation handles the environment.
for suffix in sh csh; do
  rm -f "${PREFIX}/bin/geant4.${suffix}"
  cat > "${PREFIX}/bin/geant4.${suffix}" <<'EOF'
#!/usr/bin/env bash
echo 'ERROR: geant4.sh and geant4.csh are not needed with conda'
echo 'Use "conda activate <environment>" instead'
EOF
  chmod +x "${PREFIX}/bin/geant4.${suffix}"
done
