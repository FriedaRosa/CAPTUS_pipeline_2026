#!/usr/bin/env bash


# 1. Astral prep:

# need a single .nwk file containing all gene trees for wASTRAL input
# concatenate all iqtree output files ending in .treefile into one file

PROJ="$HOME/CAPTUS_pipeline_2026"
IQTREE="$PROJ/data/05_phylogeny/nuc_gene_trees"
ASTRAL="$PROJ/data/05_phylogeny/species_tree_wASTRAL"

mkdir -p "$ASTRAL"
cat "$IQTREE"/*.treefile > "$ASTRAL/all_gene_trees.nwk"

# sanity check: count number of trees in the concatenated file
wc -l "$ASTRAL/all_gene_trees.nwk"
grep -c ';' "$ASTRAL/all_gene_trees.nwk"
# should match number of individual gene trees
find "$IQTREE"/*.treefile | wc -l

grep -o '[^(),:;]*' "$ASTRAL/all_gene_trees.nwk" | grep ' ' | head



# 2. collapse low support nodes
R --slave --no-restore --no-save -e "source('$PROJ/scripts/helper/collapse_low_support_nodes.R')"




# 3. Run wASTRAL

conda activate astral
IN_TREES="$ASTRAL/gene_trees_collapsed.nwk"


# with probability & likelihood support (x 1 n 0)
wastral \
  -i "$IN_TREES" \
  -x 1 -n 0 \
  -o "$ASTRAL/wastral_species_tree_collapsed.nwk" \
  --thread 12 \
  --mode 1



IN_TREES2="$ASTRAL/all_gene_trees.nwk"


# with probability & likelihood support (x 1 n 0)
wastral \
  -i "$IN_TREES2" \
  -x 1 -n 0 \
  -o "$ASTRAL/wastral_species_tree.nwk" \
  --thread 12 \
  --mode 1


conda deactivate