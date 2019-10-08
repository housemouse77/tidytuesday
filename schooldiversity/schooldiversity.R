rm(list=ls())

# LOAD LIBRARIES ------------------------------------------------------------------------------
library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(gridExtra)
library(grid)
library(ggalluvial)
library(data.table)

#load data
school_raw <- read.csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-24/school_diversity.csv")

school = school_raw #or a subset of it
school <- school %>% 
  mutate(LEA_NAME = tolower(LEA_NAME)) %>%
  mutate(Total = Total / 10^3) 
school <- as.data.frame(school, stringsAsFactors = FALSE) 

#pick a sample of rows
#school = school[sample(nrow(school), 1000), ]

#pick relevant columns
school = as.data.table(school)
school = school[ , .( LEAID, ST, White, Total, diverse, d_Locale_Txt, SCHOOL_YEAR) ]

#split school locations into 2 variables: location and type
school = setDT(school)[, paste0("Locale", 1:2) := tstrsplit(d_Locale_Txt, "-")]

#remove missing values
school = school[ !is.na( diverse ) & !is.na( Locale1 ) & !is.na( ST )
             & !is.na( Locale2 )]
#create total non whites
school[ , Nonwhite := 100-White ]
school[ , MajorityWhite := as.numeric(ifelse(White>50,1,0)) ]

#ggplots
ggplot(school,
       aes(axis1 = SCHOOL_YEAR,
           axis2 = diverse,
           axis3 = Locale1,
           axis4 = Locale2,
           y = Total)) +
  geom_alluvium(
    aes(fill = MajorityWhite)) +
  geom_stratum() +
  geom_text(stat = "stratum", 
            label.strata = TRUE,
            size = 2) +
  scale_x_discrete(limits = c("Years", "Diversity", "Locations", "Type")) +
  labs(title = "School Diversity Data",
       subtitle = "stratified by school diversity, location and type",
       y = "Number of Students, in thousands") +
  theme_calc() +
  theme(axis.text.x = element_text(size = 12, face = "bold"))
