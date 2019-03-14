# setwd("/fs/data3/ecowdery/ED.Hydro.Documentation/docs/")
# bookdown::render_book("index.Rmd", "bookdown::gitbook")

library(xfun)
in_dir("docs", bookdown::render_book("index.Rmd", "bookdown::gitbook"))
