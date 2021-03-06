## code to prepare `ships` dataset goes here
ships <- read.csv("inst/extdata/ships.csv")

# Data preprocessing
ships <- ships %>% mutate_each(list(factor),
                               c(DESTINATION, FLAG,
                                 SHIPNAME, PORT,
                                 ship_type, port))

ships$DATETIME <-
  as.POSIXct(ships$DATETIME, format = "%Y-%m-%dT%H:%M:%OS")

# ships <- ships[1:2000, ]

usethis::use_data(ships, overwrite = TRUE)
