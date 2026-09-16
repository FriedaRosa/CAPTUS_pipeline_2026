#!/usr/bin/env bash

conda activate captus
# Cleaning reads using captus clean command.
## it removes adapters, trims low-quality bases, and filters out reads with low average quality score.

PROJ="$HOME/CAPTUS_pipeline_2026"
cd $PROJ


captus clean \
-r './data/input/input_sequences' \
-o './data/01_cleaned_reads' \
--qc_program fastqc \
--threads 10 \
--overwrite

conda deactivate