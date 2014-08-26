rm(list = ls(all = TRUE)) #CLEAR WORKSPACE
source("functionsMH.R")
library(ggmap)
library(plyr)

db_INEGI <- read.csv("data_censo_clean.csv")

db_INEGI["perc_pob"]<-NA
db_INEGI$perc_pob<-db_INEGI$pob/sum(db_INEGI$pob)

db_INEGI_sort_pob <- db_INEGI[order(db_INEGI$perc_pob, decreasing=TRUE),]
db_INEGI_sort_pob["perc_pob_acum"]<-NA
db_INEGI_sort_pob$perc_pob_acum <- cumsum(db_INEGI_sort_pob$perc_pob)

#Get areas covered by Hotels (~33.5% of the population, Top 50 )
db_INEGI_subset_covered <- subset(db_INEGI_sort_pob, perc_pob_acum < 0.335)

simul <- gen_coords(db_INEGI_subset_covered[,6:7])
dim(simul)

map <- ggmap(
  get_googlemap(
    center=c(-103.130762, 22.656849), #Long/lat of centre, or "Edinburgh"
    zoom=5, 
    maptype='roadmap', #also hybrid/terrain/roadmap
    scale = 2), #resolution scaling, 1 (low) or 2 (high)
  size = c(700, 700), #size of the image to grab
  extent='device', #can also be "normal" etc
  darken = 0) #you can dim the map when plotting on top

map + geom_point(data = db_INEGI_subset_covered[,6:7], aes(x=long, y=lat), alpha = 1)