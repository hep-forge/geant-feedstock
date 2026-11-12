# geant-feedstock

[![hep-forge](https://img.shields.io/badge/package-hep--forge%2Fgeant-orange.svg)](https://anaconda.org/hep-forge/geant)
[![Build & Upload](https://github.com/hep-forge/geant-feedstock/actions/workflows/autoupload.yml/badge.svg)](https://github.com/hep-forge/geant-feedstock/actions/workflows/autoupload.yml)
[![Anaconda Version](https://anaconda.org/hep-forge/geant/badges/version.svg)](https://anaconda.org/hep-forge/geant)
[![Anaconda Platforms](https://anaconda.org/hep-forge/geant/badges/platforms.svg)](https://anaconda.org/hep-forge/geant)

Feedstock for [geant](https://geant4.web.cern.ch) — part of [hep-forge](https://anaconda.org/hep-forge).
Builds linux-amd64 + linux-arm64 in one matrix workflow and uploads to the
[hep-forge](https://anaconda.org/hep-forge) Anaconda channel.

Geant detector simulation: Geant4 from conda-forge's geant4, Geant3.21 + TGeant3 compiled (geant<4)

## Architectures

| Architecture | Latest published |
|--------------|------------------|
| linux-amd64 (`linux-64`) | ✅ `11.4.3` |
| linux-arm64 (`linux-aarch64`) | ✅ `11.4.3` |

_As of the last feedstock render; the badges above are live._


## Install

```bash
conda install -c hep-forge -c conda-forge geant
```

## Maintainers

* [@meiyasan](https://github.com/meiyasan/)

