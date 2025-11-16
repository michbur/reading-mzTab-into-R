all_files <- list.files("examples", full.names = TRUE, pattern = "mztab")

source("test-Metaboanalyst.R")

unlink("docs")
rmarkdown::render("index.Rmd", output_dir = "docs")
