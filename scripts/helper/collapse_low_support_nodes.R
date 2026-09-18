library(ape)

trees <- read.tree("data/05_phylogeny/species_tree_wASTRAL/all_gene_trees.nwk")

collapse_support <- function(tr, threshold = 60) {

  # extract first support value
  sup <- sapply(strsplit(tr$node.label, "/"),
                function(x) as.numeric(x[1]))

  # find nodes below threshold
  bad_nodes <- which(sup < threshold) + Ntip(tr)

  tr$edge.length[is.na(tr$edge.length)] <- 0

  for (node in rev(bad_nodes)) {
    tr <- di2multi(tr, tol = 0)
    descendants <- which(tr$edge[, 2] == node)

    if (length(descendants) > 0)
      tr$edge.length[descendants] <- 0
  }

  di2multi(tr, tol = 1e-8)
}

trees_collapsed <- lapply(trees, collapse_support, threshold = 60)

par(mfrow = c(2, 2))
plot(trees[[1]], main = "Original")
plot(trees_collapsed[[1]], main = "Collapsed")
plot(trees[[2]], main = "Original")
plot(trees_collapsed[[2]], main = "Collapsed")



write.tree(trees_collapsed,
  file = "data/05_phylogeny/species_tree_wASTRAL/gene_trees_collapsed.nwk"
)