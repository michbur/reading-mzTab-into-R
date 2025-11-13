source("renv/activate.R")
options(renv.config.pak.enabled = FALSE)
renv::restore(exclude = "MetaboAnalystR")
