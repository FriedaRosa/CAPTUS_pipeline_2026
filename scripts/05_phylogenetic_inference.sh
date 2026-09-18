#!/usr/bin/env bash

conda activate captus


mkdir "./data/05_phylogeny"
cd "./data/05_phylogeny" || return

## 1. Concatenation species-tree using all loci and an edge-linked partition model (nuclear genes, mito genes, plastid genes)

iqtree2 \
    -p "../04_alignments/03_trimmed/06_informed/01_coding_NUC/02_NT/" \
    -m MFP+MERGE \
    --ufboot 1000 \
    -pre concat \
    -T AUTO \
    --undo

iqtree2 \
    -p "../04_alignments/03_trimmed/06_informed/02_coding_PTD/02_NT/" \
    -m MFP+MERGE \
    --ufboot 1000 \
    -pre concat_ptd \
    -T AUTO \
    --undo

iqtree2 \
    -p "../04_alignments/03_trimmed/06_informed/03_coding_MIT/02_NT/" \
    -m MFP+MERGE \
    --ufboot 1000 \
    -pre concat_mit \
    -T AUTO \
    --undo

## 2. Gene tree inference
PROJ="$HOME/CAPTUS_pipeline_2026"

ALIGN="$PROJ/data/04_alignments/03_trimmed/06_informed/01_coding_NUC/02_NT"
OUT="$PROJ/data/05_phylogeny"

mkdir -p "$OUT/nuc_gene_trees"

for aln in "$ALIGN"/*.fna; do
    gene=$(basename "$aln" .fna)

    echo "Running IQ-TREE for gene: $gene"

    iqtree2 \
        -s "$aln" \
        -m MFP \
        --ufboot 1000 \
        -pre "$OUT/nuc_gene_trees/$gene" \
        -T AUTO \
        --undo
done

conda deactivate