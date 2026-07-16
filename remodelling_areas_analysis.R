run_remodelling_model <- function(outcome) {

  formula <- as.formula(
    paste0(
      "log(",
      outcome,
      "+0.001) ~ Treatment + AirwayM + Treatment:AirwayM + (1|fa)"
    )
  )

  model <- lmer(
    formula,
    data = Col
  )

  summary(model)

  plot(model)

  return(model)
}
