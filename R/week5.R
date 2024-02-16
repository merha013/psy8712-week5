# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
Adata_tbl <- read_delim("../data/Aparticipants.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Anotes_tbl <- read_csv("../data/Anotes.csv")
Bdata_tbl <- read_tsv("../data/Bparticipants.dat", col_names = c("casenum", "parnum", "stimver", "datadate", "q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "q10")) ### there is probably a shorter way to label q1-q10...
Bnotes_tbl <- read_tsv("../data/Bnotes.txt")

# Data Cleaning
Aclean_tbl <- Adata_tbl %>%
  separate(qs, into=paste0("q",1:5)) %>%
  left_join(Anotes_tbl, by = "parnum") %>%
  filter(is.na(notes))

Aclean_tbl$datadate <- mdy_hms(Aclean_tbl$datadate) # needs to go in line 14
Aclean_tbl[,paste0("q",1:5)] <- sapply(Aclean_tbl[,paste0("q", 1:5)], as.integer) # needs to go in line 15

# this next section needs to begin on line 18
ABclean_tbl <- Bdata_tbl %>%
  left_join(Bnotes_tbl, by = "parnum") %>%
  filter(is.na(notes))
  # inner_join(Aclean_tbl)

ABclean_tbl$datadate <- mdy_hms(ABclean_tbl$datadate) # needs to go in line 19
ABclean_tbl[,5:14] <- sapply(Aclean_tbl[,5:14], as.integer) # needs to go in line 20, and needs to use other code than 5:14
