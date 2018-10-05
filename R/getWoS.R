library(wosr)
#require("bibliometrix")
library(lubridate)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(grid)
library(stringr)
library(stopwords)

#Variables
scale = 1

token <- auth(username = NULL, password = NULL)

query <- "TS =((GPGPU OR GPU OR NVIDIA) AND ('GENETIC ALGORITHM' OR 'EVOLUTIONARY ALGORITHM' OR 'DIFFERENTIAL EVOLUTION' OR 'GENETIC PROGRAMMING' OR 'EVOLUTION STRATEGIES'))"

query_wos(query,
          sid = token,  
          editions = c("SCI", "SSCI", "AHCI", "ISTP", "ISSHP", "BSCI","BHCI", "IC", "CCR", "ESCI"))

d <- pull_wos(query,
              sid = token,
              editions = c("SCI", "SSCI", "AHCI", "ISTP", "ISSHP", "BSCI","BHCI", "IC", "CCR", "ESCI"))

#Pequeño post-procesamiento
d$publication$date.y <- year(d$publication$date)
d$publication$title <- toupper(d$publication$title)
d$keyword$keyword <- toupper(d$keyword$keyword)
d$publication$abstract <- str_remove_all(d$publication$abstract, "[[:punct:]]")


saveRDS(d,file = "WoS_database")
