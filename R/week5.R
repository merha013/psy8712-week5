# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
Adata_tbl <- read_delim("../data/Aparticipants.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Anotes_tbl <- read_csv("../data/Anotes.csv")
Bdata_tbl <- read_tsv("../data/Bparticipants.dat", col_names = c("casenum", "parnum", "stimver", "datadate", "q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "q10")) ### there is probably a shorter way to label q1-q10...
Bnotes_tbl <- read_tsv("../data/Bnotes.txt")

# Data Cleaning
# Aclean_tbl <- Adata_tbl %>%
separate(Adata_tbl, qs, into=paste0("q",1:5))
  # datadate <- mdy_hms(datadate) %>%  # still need to figure out how to do this part inside a pipe
  # sapply(Adata_tbl[,paste0("q", 1:5)], as.integer)

