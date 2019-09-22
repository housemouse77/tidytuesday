# National Parks TidyTuesday Challenge
This is my contribution to the #tidytuesday challenge of data visualizations in R. https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-09-17

The data on US National Park visit was provided by https://data.world/inform8n/us-national-parks-visitation-1904-2016-with-boundaries, and the goal was to come up with a new way to visualize it. 

Given that we had a time series data by years of visitors in various parks, I chose a stacked area chart to show the number of visitors in millions. The fact that we know the geographic location of the park allowed me to connect the data with the spatial representation of corresponding US regions on the map. The two charts (area chart with number of visitors per year and the map with different regions used by NPS are connected using the  common color scheme of the regions (e.g. Pacific West part of the chart is colored blue. and the respective map area is also blue).

The repository contains the original dataset, R code for visualization and the resulting chart.

![alt text](https://raw.githubusercontent.com/housemouse77/tidytuesday/national parks/Rplot.png)
