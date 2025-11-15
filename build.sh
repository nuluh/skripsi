#!/bin/bash
set -e

echo "Building skripsi.cls..."
cd ./src
latexmk -xelatex -silent -outdir=.build skripsi.dtx

echo "Rewrite index"
cd .build
makeindex -s gind.ist skripsi
cd ..
latexmk -xelatex -silent -outdir=.build skripsi.dtx
latexmk -c -outdir=.build skripsi.dtx

echo "✅ Build complete!"