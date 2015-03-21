# Unidentified Flying Object (UFO) Sightings - Summary Analysis
# Assignment
# You work for a media company, which is publishing an article 
# on UFO sightings. Your boss comes to you because he needs a 
# summary on historical UFO sightings.

# Author "Richard Ngamita" ngamita@gmail.com


# Set working directory to BIA.xlsx file location
setwd('~/Code/BIA/')

# Read the Excel sheet file into R. 
# Note that it's on the tab 2 called "UFO Data"
library(xlsx)
library(plyr)
library(tidyr)
ufo_data <- read.xlsx(file = 'BIA_ExcelExercise.xlsx',
                      sheetIndex = 2, header = TRUE)

# Filter by Year greater or equal to 1950. 
ufo_data_1950 <- ufo_data[ufo_data$Year >= 1950,]

# Use plyrs count function. 
count(ufo_data_1950, 'Location')


## Q. 2
## Rename variables (column headers)
names(ufo_data_1950) <- c('Year', 'Name_of_Sighting_Event', 
                          'Location', 'Physical_Effects', 'Multimedia', 'ET_Contact', 'Abduction')

## Melt or Gather to reshape the data. 
# The arguments to gather():
# - data: Data object
# - key: Name of new key column (made from names of data columns)
# - value: Name of new value column
# - ...: Names of source columns that contain values
ufo_data_1950_wide <- ufo_data_1950
ufo_data_1950_long <- gather(ufo_data_1950_wide, type, status, Physical_Effects:Abduction)

## Select only those where status == 1 means 'Yes' for the type of UFO Sighting. 
ufo_data_1950_long_yes <- ufo_data_1950_long[ufo_data_1950_long$status == 1, ]

## Aggregate by the count of each Type of UFO sighting by location. 
count_sightings_location <- count(ufo_data_1950_long_yes, c("Location", "type")) 

## Arrane descending. Using tidyrs arrange function. 
count_sightings_location_desc <- count_sightings_location %>% arrange(desc(freq))

## Group by Years and count.
ufo_data_year <- ufo_data
names(ufo_data_year) <- c('Year', 'Name_of_Sighting_Event', 
                          'Location', 'Physical_Effects', 'Multimedia', 'ET_Contact', 'Abduction')

ufo_data_year_long <- gather(ufo_data_year, type, status, Physical_Effects:Abduction)
ufo_data_year_long_yes <- ufo_data_year_long[ufo_data_year_long$status == 1, ]
top_sightings <- count(ufo_data_year_long_yes, "Year") %>% arrange(desc(freq))
## Print the top most Year and frequency of sightings. 
top_sightings[1,]





