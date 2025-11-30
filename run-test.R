renv::activate(profile = "rendering")
if(!require("callr")) {
  renv::restore()
  require("callr")
}

for(ith_file in list.files("test-scripts", full.names = TRUE, pattern = "test-")) {
  source(ith_file)
}

all_files <- list.files("examples", full.names = TRUE, pattern = "mztab")

all_test_functions <- ls()[grepl("^test_", ls())]

all_imports <- lapply(all_test_functions, function(ith_test_fun) {
  r(get(ith_test_fun), args = list(all_files = all_files))
}) |>
  setNames(gsub("^test_", "", all_test_functions))

import_df <- lapply(names(all_imports), function(ith_name) {
  factor(all_imports[[ith_name]][[1]], levels = c("error", "silent failure", "success"))
}) |>
  do.call(cbind.data.frame, args = _) |>
  data.frame() |>
  setNames(names(all_imports)) 


jmztabm_commands <- paste0("java -jar jmztabm-cli.jar -c ", all_files, " -l Info")

jmztabm_res <- lapply(jmztabm_commands, function(ith_command) {
  system(ith_command, intern = TRUE)
})

unlink("docs")
rmarkdown::render("index.Rmd", output_dir = "docs")



