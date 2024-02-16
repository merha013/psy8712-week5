# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
Adata_tbl <- read_delim("../data/Aparticipants.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Anotes_tbl <- read_csv("../data/Anotes.csv")
Bdata_tbl <- read_tsv("../data/Bparticipants.dat", col_names = c("casenum", "parnum", "stimver", "datadate", paste0("q", 1:10)))
Bnotes_tbl <- read_tsv("../data/Bnotes.txt")

# Data Cleaning
Aclean_tbl <- Adata_tbl %>%
  separate(qs, into=paste0("q",1:5)) %>%
  mutate(datadate = mdy_hms(datadate)) %>%
  mutate(sapply(FUN = as.integer, paste0("q",1:5))) # doesn't work
  left_join(Anotes_tbl, by = "parnum") %>%
  filter(is.na(notes))

Aclean_tbl[,paste0("q",1:5)] <- sapply(Aclean_tbl[,paste0("q", 1:5)], as.integer) # needs to go in line 15

# this next section needs to begin on line 18
ABclean_tbl <- Bdata_tbl %>%
  mutate(datadate = mdy_hms(datadate)) %>%
  left_join(Bnotes_tbl, by = "parnum") %>%
  filter(is.na(notes))
  # inner_join(Aclean_tbl)

ABclean_tbl[,5:14] <- sapply(Aclean_tbl[,5:14], as.integer) # needs to go in line 20, and needs to use other code than 5:14
