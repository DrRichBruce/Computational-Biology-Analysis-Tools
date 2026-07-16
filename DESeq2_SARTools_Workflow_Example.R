################################################################################
# RNA-seq Differential Expression Workflow
#
# Adapted and applied by: Dr Richard Bruce
#
# Based on:
# SARTools and DESeq2 workflows developed by their respective authors.
#
# Purpose:
# - Import featureCounts outputs
# - Differential expression analysis of RNA-seq data
# - PCA and clustering
# - Quality control
# - Annotated result export
#
# Notes:
# This workflow was adapted from bioinformatics training materials and used
# during transcriptomic analysis projects.
################################################################################
#---------------------------------------------------------------------------
# Install packages (required only once)
#---------------------------------------------------------------------------

# install.packages("devtools")
# library(devtools)
# devtools::install_github(
#   "PF2-pasteur-fr/SARTools",
#   build_opts = "--no-resave-data"
# )

#---------------------------------------------------------------------------
# Load libraries
#---------------------------------------------------------------------------

library(SARTools)
library(dplyr)

#---------------------------------------------------------------------------
# Clear workspace
#---------------------------------------------------------------------------

rm(list = ls())

#---------------------------------------------------------------------------
# User-defined parameters
#---------------------------------------------------------------------------

# Main project directory
workDir <- "PATH_TO_PROJECT_DIRECTORY"

# Project information
projectName <- "RNAseq_Project"
author <- "Dr Richard Bruce"

# Input files
targetFile <- file.path(workDir, "Targets.txt")
rawDir <- file.path(workDir, "featureCounts")

# Optional gene annotation file
IDtoGene <- read.delim(
  file.path(workDir, "gene_annotation_map.txt"),
  header = TRUE
)

# Features to remove
featuresToRemove <- c(
  "alignment_not_unique",
  "ambiguous",
  "no_feature",
  "not_aligned",
  "too_low_aQual"
)

# Experimental design
varInt <- "Condition"
condRef <- "Control"
batch <- NULL

# Statistical settings
fitType <- "parametric"
cooksCutoff <- TRUE
independentFiltering <- TRUE
alpha <- 0.05
pAdjustMethod <- "BH"

# PCA/clustering settings
typeTrans <- "VST"
locfunc <- "median"

# Plot colours
colors <- c(
  "#f3c300", "#875692", "#f38400",
  "#a1caf1", "#be0032", "#c2b280",
  "#848482", "#008856", "#e68fac",
  "#0067a5", "#f99379", "#604e97"
)

# Graphics settings
forceCairoGraph <- FALSE

#---------------------------------------------------------------------------
# Run analysis
#---------------------------------------------------------------------------

setwd(workDir)

if (forceCairoGraph) {
  options(bitmapType = "cairo")
}

#---------------------------------------------------------------------------
# Check analysis parameters
#---------------------------------------------------------------------------

checkParameters.DESeq2(
  projectName = projectName,
  author = author,
  targetFile = targetFile,
  rawDir = rawDir,
  featuresToRemove = featuresToRemove,
  varInt = varInt,
  condRef = condRef,
  batch = batch,
  fitType = fitType,
  cooksCutoff = cooksCutoff,
  independentFiltering = independentFiltering,
  alpha = alpha,
  pAdjustMethod = pAdjustMethod,
  typeTrans = typeTrans,
  locfunc = locfunc,
  colors = colors
)

#---------------------------------------------------------------------------
# Load target file
#---------------------------------------------------------------------------

target <- loadTargetFile(
  targetFile = targetFile,
  varInt = varInt,
  condRef = condRef,
  batch = batch
)

#---------------------------------------------------------------------------
# Load count data
#---------------------------------------------------------------------------

counts <- loadCountData(
  target = target,
  rawDir = rawDir,
  featuresToRemove = featuresToRemove
)

#---------------------------------------------------------------------------
# Quality control plots
#---------------------------------------------------------------------------

majSequences <- descriptionPlots(
  counts = counts,
  group = target[, varInt],
  col = colors
)

#---------------------------------------------------------------------------
# Differential expression analysis
#---------------------------------------------------------------------------

out.DESeq2 <- run.DESeq2(
  counts = counts,
  target = target,
  varInt = varInt,
  batch = batch,
  locfunc = locfunc,
  fitType = fitType,
  pAdjustMethod = pAdjustMethod,
  cooksCutoff = cooksCutoff,
  independentFiltering = independentFiltering,
  alpha = alpha
)

#---------------------------------------------------------------------------
# PCA and clustering
#---------------------------------------------------------------------------

exploreCounts(
  object = out.DESeq2$dds,
  group = target[, varInt],
  typeTrans = typeTrans,
  col = colors
)

#---------------------------------------------------------------------------
# Result summaries
#---------------------------------------------------------------------------

summaryResults <- summarizeResults.DESeq2(
  out.DESeq2,
  group = target[, varInt],
  col = colors,
  independentFiltering = independentFiltering,
  cooksCutoff = cooksCutoff,
  alpha = alpha
)

#---------------------------------------------------------------------------
# Save R session
#---------------------------------------------------------------------------

save.image(
  file = paste0(projectName, ".RData")
)

#---------------------------------------------------------------------------
# Generate HTML report
#---------------------------------------------------------------------------

writeReport.DESeq2(
  target = target,
  counts = counts,
  out.DESeq2 = out.DESeq2,
  summaryResults = summaryResults,
  majSequences = majSequences,
  workDir = workDir,
  projectName = projectName,
  author = author,
  targetFile = targetFile,
  rawDir = rawDir,
  featuresToRemove = featuresToRemove,
  varInt = varInt,
  condRef = condRef,
  batch = batch,
  fitType = fitType,
  cooksCutoff = cooksCutoff,
  independentFiltering = independentFiltering,
  alpha = alpha,
  pAdjustMethod = pAdjustMethod,
  typeTrans = typeTrans,
  locfunc = locfunc,
  colors = colors
)

#---------------------------------------------------------------------------
# Annotate differential expression tables
#---------------------------------------------------------------------------

tables <- list.files(
  path = "tables",
  pattern = "*.txt",
  full.names = TRUE,
  recursive = FALSE
)

lapply(tables, function(x) {

  results_table <- read.table(
    x,
    header = TRUE
  )

  results_subset <- select(
    results_table,
    Id,
    log2FoldChange,
    pvalue,
    padj
  )

  annotated_results <- merge(
    results_subset,
    IDtoGene,
    by = "Id"
  )

  write.table(
    annotated_results,
    file = paste0(x, ".annot.csv"),
    sep = "\t",
    quote = FALSE,
    row.names = FALSE,
    col.names = TRUE
  )

})
