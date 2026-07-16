###########################################################
# Basic Heatmap Generation
#
# Author: Dr Richard Bruce
#
# Purpose:
# Generate clustered heatmaps from gene expression data.
#
# Expected input:
# Rows = genes
# Columns = samples
###########################################################

# Load packages
library(RColorBrewer)
library(gplots)

# Import data
# Select a CSV file interactively
expr <- read.csv(
  file.choose(),
  header = TRUE,
  row.names = 1
)

# Define colour palette
heatmap_palette <- colorRampPalette(
  brewer.pal(9, "Reds")
)

# Generate heatmap
heatmap.2(
  data.matrix(log2(expr + 1)),
  Rowv = TRUE,
  Colv = TRUE,
  col = heatmap_palette,
  main = "Gene Expression Heatmap",
  cexRow = 0.5,
  cexCol = 0.8,
  trace = "none",
  density.info = "none"
)
