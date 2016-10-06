#!/bin/bash
export CONDA_ROOT="$HOME/miniconda/envs/oddt_env/"

cp /usr/local/Cellar/upx/3.91_1/bin/upx .
./upx --help

pyinstaller \
    --clean \
    --hidden-import=six \
    --hidden-import=sklearn.tree._utils \
    --hidden-import=compiledtrees \
    --hidden-import=rdkit \
    --exclude-module tcl \
    --exclude-module Tkinter \
    --add-data "${CONDA_ROOT}/share/openbabel/2.4.0/*:data/" \
    --add-data "${CONDA_ROOT}/share/RDKit/Data/*:rdkit/Data" \
    --add-binary "${CONDA_ROOT}/lib/openbabel/2.4.0/mdlformat.so:." \
    --add-binary "${CONDA_ROOT}/lib/openbabel/2.4.0/mol2format.so:." \
    --add-binary "${CONDA_ROOT}/lib/openbabel/2.4.0/pdbformat.so:." \
    --add-binary "${CONDA_ROOT}/lib/openbabel/2.4.0/pdbqtformat.so:." \
    --add-binary "${CONDA_ROOT}/lib/openbabel/2.4.0/smilesformat.so:." \
    --runtime-hook pyi_rth_obdata.py \
    --runtime-hook pyi_rth_rdkit.py \
    --add-data=${CONDA_ROOT}/lib/python2.7/site-packages/oddt/scoring/functions/RFScore/*.csv:oddt/scoring/functions/RFScore/ \
    --add-data=${CONDA_ROOT}/lib/python2.7/site-packages/oddt/scoring/functions/NNScore/*.csv:oddt/scoring/functions/NNScore/ \
    --nowindow \
    --strip \
    --add-binary "${CONDA_ROOT}/lib/libinchi.0.dylib:." \
    --add-binary "/opt/X11/lib/libcairo.2.dylib:." \
    --add-binary "/opt/X11/lib/libxcb-render.0.dylib:." \
    --add-binary "/opt/X11/lib/libxcb-shm.0.dylib:." \
    --add-binary "/opt/X11/lib/libfontconfig.1.dylib:." \
    --add-binary "/opt/X11/lib/libXrender.1.dylib:." \
    --add-binary "/opt/X11/lib/libpng16.16.dylib:." \
    --add-binary "/opt/X11/lib/libX11-xcb.1.dylib:." \
    --add-binary "/opt/X11/lib/libfreetype.6.dylib:." \
    --add-binary "/opt/X11/lib/libxcb.1.dylib:." \
    --add-binary "/opt/X11/lib/libX11.6.dylib:." \
    --add-binary "/opt/X11/lib/libpixman-1.0.dylib:." \
    --add-binary "/opt/X11/lib/libXext.6.dylib:." \
    --add-binary "/opt/X11/lib/libXau.6.dylib:." \
    --add-binary "/opt/X11/lib/libXdmcp.6.dylib:." \
    --add-binary "/opt/X11/lib/libxcb.1.dylib:." \
    --upx-dir . \
    --additional-hooks-dir=. \
    -n oddt_cli --onefile ${CONDA_ROOT}/bin/oddt_cli
