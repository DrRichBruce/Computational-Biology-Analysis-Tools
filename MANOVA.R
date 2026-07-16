###########################################################
# MANOVA Analysis
#
# Author: Dr Richard Bruce
#
# Purpose:
# Assess treatment effects across multiple
# histological outcome variables simultaneously.
###########################################################

library(dplyr)

# Import data
Col <- read.csv(
  file.choose(),
  header = TRUE
)

# Convert animal identifier
Col$fa <- factor(Col$Animal)

# Perform MANOVA
manova_model <- manova(
  cbind(
    Col$EpiT,
    Col$EpiM,
    (Col$RBMC + Col$PBC),
    Col$PVPBN
  ) ~ Treatment,
  data = Col
)

# View results
summary(manova_model)
