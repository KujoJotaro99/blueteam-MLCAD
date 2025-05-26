docker run --rm -it \
  -e PATH="/app/MLCAD25-Contest-Scripts-Benchmarks/OpenROAD/build/src:${PATH}" \
  -v "$(pwd)":/workspace \
  --name mlcad-dev \
  mlcad_update \
  bash
