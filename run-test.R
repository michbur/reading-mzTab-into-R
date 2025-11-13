library("MetaboAnalystR")

all_files <- list.files("examples", full.names = TRUE, pattern = "mztab")

all_reads <- lapply(all_files, function(ith_file_name) {
  # there are many global assignments in metaboanalystR 
  # so we initiate and remove objects every loop and we clean the global
  rm(list = setdiff(ls(), c("all_files", "ith_file_name")))
  
  # we use a non-standard anal.type to avoid Rserve initialization 
  mSet <- InitDataObjects("mztab", "anything", FALSE, default.dpi = 150)
  res <- try(Read.mzTab(mSet, ith_file_name, identifier = "name"), 
             silent = TRUE)
  res
})

unlink("docs")
rmarkdown::render("index.Rmd", output_dir = "docs")
