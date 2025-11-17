renv::activate(profile = "rendering")
if(!require("callr")) {
  renv::restore()
  require("callr")
}

source("test-Metaboanalyst.R")

all_files <- list.files("examples", full.names = TRUE, pattern = "mztab")

all_test_functions <- ls()[grepl("^test_", ls())]

all_imports <- lapply(all_test_functions, function(ith_test_fun) {
  r(get(ith_test_fun), args = list(all_files = all_files))
}) |>
  setNames(gsub("^test_", "", all_test_functions))

import_df <- lapply(names(all_imports), function(ith_name) {
  as.factor(all_imports[[ith_name]][[1]])
}) |>
  do.call(cbind.data.frame, args = _) |>
  data.frame() |>
  setNames(names(all_imports)) |>
  cbind(file = basename(all_files), x = _)

unlink("docs")
rmarkdown::render("index.Rmd", output_dir = "docs")



