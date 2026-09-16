#!/usr/bin/env bash

conda activate captus


captus extract \
-a './data/02_assemblies' \
-o './data/03_extractions' \
-n Mega353 \
-p SeedPlantPTD \
-m SeedPlantsMIT


conda deactivate