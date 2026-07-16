###########################################################
# Immunoreactivity Mixed-Effects Analysis
#
# Author: Dr Richard Bruce
#
# Purpose:
# Analyse quantitative immunoreactivity measurements using
# hierarchical linear mixed-effects models while accounting
# for both biological and technical sources of variation.
#
# Experimental Structure:
#
# Fixed Effects:
# - Treatment
# - Technical Repeat
#
# Random Effects:
# - Biological Sample × Technical Repeat
#
# Outcomes:
# - Raw immunoreactivity measurements
# - Normalised immunoreactivity measurements
#
# Biological Motivation:
# Quantitative immunostaining experiments frequently contain
# repeated observations from the same biological sample and
# multiple technical replicates.
#
# This workflow estimates treatment-associated effects while
# accounting for hierarchical experimental structure and
# non-independent observations.
###########################################################

#----------------------------------------------------------
# Load data
#----------------------------------------------------------

Col <- read.csv(
  file.choose(),
  header = TRUE
)

# Inspect dataset
summary(Col)

#----------------------------------------------------------
# Convert grouping variables to factors
#----------------------------------------------------------

Col$Sample <- factor(Col$Animal)
Col$TechnicalRepeat <- factor(Col$Repeat)

#----------------------------------------------------------
# Load required packages
#----------------------------------------------------------

library(lme4)
library(lmerTest)

#==========================================================
# MODEL 1
# Raw Immunoreactivity Measurements
#==========================================================

raw_model <- lmer(
  RawIntensity ~
    Treatment +
    Repeat +
    (1 | Sample:TechnicalRepeat),
  data = Col
)

summary(raw_model)

confint(
  raw_model,
  method = "Wald"
)

plot(raw_model)

#==========================================================
# MODEL 2
# Normalised Immunoreactivity Measurements
#==========================================================

normalised_model <- lmer(
  NormalisedIntensity ~
    Treatment +
    Repeat +
    (1 | Sample:TechnicalRepeat),
  data = Col
)

summary(normalised_model)

confint(
  normalised_model,
  method = "Wald"
)

plot(normalised_model)

#==========================================================
# INTERPRETATION GUIDE
#==========================================================

# Treatment:
# Estimates treatment-associated changes in
# immunoreactivity after accounting for technical
# variation.

# Repeat:
# Estimates systematic variation attributable
# to technical replicates.

# Random Effect:
# Accounts for clustering arising from repeated
# measurements obtained from the same biological
# sample and technical replicate.

# Significant treatment effects suggest biological
# differences independent of technical variation.
