## code to prepare `movies` dataset goes here
pth <- system.file('extdata/movies.RData', package = 'myLeprechaunApp')
load(pth)
usethis::use_data(movies, overwrite = TRUE)
