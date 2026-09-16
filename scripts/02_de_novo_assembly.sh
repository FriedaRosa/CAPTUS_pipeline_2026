#!/usr/bin/env bash

conda activate captus

captus assemble \
-r ./data/01_clean_reads \
-o ./data/02_assemblies \
--threads 'auto' 

conda deactivate