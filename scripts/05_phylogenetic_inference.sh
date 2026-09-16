#!/usr/bin/env bash

conda activate captus


mkdir './data/05_phylogeny' && cd './data/05_phylogeny'

## 1. Concatenation species-tree using all loci and an edge-linked partition model (nuclear genes, mito genes, plastid genes)

iqtree \
-p ../04_alignments/03_trimmed/06_informed/01_coding_NUC/02_NT \
-pre concat \
-T AUTO

iqtree \
-p ../04_alignments/03_trimmed/06_informed/02_coding_PTD/03_NT \
-pre concat \
-T AUTO

iqtree \
-p ../04_alignments/03_trimmed/06_informed/03_coding_MIT/02_NT \
-pre concat \
-T AUTO


## 2. Gene tree inference
PROJ="$HOME/CAPTUS_pipeline_2026"
ALIGN=$PROJ/data/04_alignments/03_trimmed/06_informed/01_coding_NUC/02_NT
OUT=$PROJ/data/05_phylogeny
mkdir -p "$OUT"

for ALN in $ALIGN/*_aligned.fasta; do
    BASENAME=$(basename "$ALN" .fasta)
    iqtree2 -s "$ALN" \
        -m MFP \
        --ufboot 1000 \
        --alrt 1000 \
        -pre "$OUT/$BASENAME" \
        --prefix "trees/$name" 
done


## 3. Plastid tree

## 4. Mito tree

conda deactivate