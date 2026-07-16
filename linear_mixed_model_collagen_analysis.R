###########################################################
# Collagen Distribution Analysis
# Author: Richard Bruce
#
# Objective:
# Model collagen abundance as a function of airway radius
# and treatment group using a mixed-effects model.
#
# Fixed effects:
# - Radius (2nd-order polynomial)
# - Treatment
# - Radius × Treatment interaction
#
# Random effects:
# - Animal ID
###########################################################

# Load packages
library(lme4)

#----------------------------------------------------------
# Import data
#----------------------------------------------------------

Col <- read.csv(file.choose(), header = TRUE)

# Convert variables to factors
Col$Treatment <- factor(Col$Treatment)
Col$fa <- factor(Col$Animal)

# Set Control as reference level
Col$Treatment <- relevel(Col$Treatment, ref = "Control")

#----------------------------------------------------------
# Fit mixed-effects model
#----------------------------------------------------------

model <- lmer(
  log10(Collagen + 0.01) ~
    poly(Radius, 2) +
    Treatment +
    poly(Radius, 2):Treatment +
    (1 | fa),
  data = Col
)

# Model summary
summary(model)

#----------------------------------------------------------
# Generate predictions
#----------------------------------------------------------

radius_seq <- seq(0, 210, by = 5)

pred_control <- predict(
  model,
  newdata = data.frame(
    Treatment = "Control",
    Radius = radius_seq,
    fa = NA
  ),
  re.form = NA
)

pred_challenge <- predict(
  model,
  newdata = data.frame(
    Treatment = "Challenge",
    Radius = radius_seq,
    fa = NA
  ),
  re.form = NA
)

pred_drug <- predict(
  model,
  newdata = data.frame(
    Treatment = "Drug",
    Radius = radius_seq,
    fa = NA
  ),
  re.form = NA
)

#----------------------------------------------------------
# Plot fitted relationships
#----------------------------------------------------------

plot(
  radius_seq,
  pred_control,
  type = "l",
  lwd = 2,
  col = "black",
  xlab = "Radius (µm)",
  ylab = "Predicted log10(Collagen + 0.01)",
  main = "Predicted Collagen Distribution"
)

lines(
  radius_seq,
  pred_challenge,
  col = "red",
  lwd = 2
)

lines(
  radius_seq,
  pred_drug,
  col = "blue",
  lwd = 2
)

legend(
  "topright",
  legend = c("Control", "Challenge", "Drug"),
  col = c("black", "red", "blue"),
  lwd = 2,
  bty = "n"
)

#----------------------------------------------------------
# Diagnostics
#----------------------------------------------------------

plot(model)
