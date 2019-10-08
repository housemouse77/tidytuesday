rm(list=ls())

# LOAD LIBRARIES ------------------------------------------------------------------------------
library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggthemes)
#library(gridExtra)
#library(grid)
library(data.table)
library(Hmisc)

#load data
ipf_lifts <- read.csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-08/ipf_lifts.csv")
ipf_lifts = as.data.table(ipf_lifts)
champs = ipf_lifts[place ==3 |place ==2 | place ==1 ]
champs = champs[age_class!="NA"] #exclude NA
champs = champs[, lift_per_kg := best3bench_kg / bodyweight_kg ]
  p<-ggplot(champs, aes(x=age_class, y=lift_per_kg, fill = sex)) + 
  geom_violin(trim=TRUE) +
  theme_economist_white() + 
  labs(title="Do Champions Lift More Than They Weigh?",
       x="Age Group", 
       y = "Best Lifted per Own Bodyweight ") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
  

nonchamps = ipf_lifts[place !=3 & place !=2 & place !=1 ]
nonchamps = nonchamps[best3bench_kg>=0] #exclude negative weights
nonchamps = nonchamps[age_class!="5-12"] #exclude small kids
nonchamps = nonchamps[, lift_per_kg := best3bench_kg / bodyweight_kg ]
nonchamps = nonchamps[, lift_per_year := best3bench_kg / age ]

q<-ggplot(nonchamps, aes(x=age_class, y=lift_per_kg, fill = sex)) + 
  geom_violin(trim=TRUE) +
  theme_economist_white() + 
  labs(title="What About Non-Champions?",
       x="Age Group", 
       y = "Best Lifted per Own Bodyweight ") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
grid.arrange(p, q, ncol=1)

