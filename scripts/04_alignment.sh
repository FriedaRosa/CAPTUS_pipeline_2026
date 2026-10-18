#!/usr/bin/env bash

conda activate captus


captus align \
-e './data/03_extractions' \
-o './data/04_alignments' \
-m ALL \
-f ALL \
--clipkit_method kpic-smart-gap \
--outgroup 'Spondianthus_preussii'


conda deactivate