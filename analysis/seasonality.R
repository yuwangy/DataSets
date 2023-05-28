library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyverse)

# Load the cab_data and customer_id data sets
cab_data <- read.csv("https://raw.githubusercontent.com/yuwangy/DataSets/main/Cab_Data.csv")

# Convert Date column to Date format
cab_data$Date <- as.Date(cab_data$Date, format = "%m/%d/%Y", origin ="2016-01-01")

# Extract month from Date
cab_data$Month <- month(cab_data$Date)

# Filter data for Pink Cab and Yellow Cab separately
pink_cab_trips <- cab_data %>% 
  filter(Company == "Pink Cab") %>%
  group_by(Month) %>%
  summarize(total_trips = n())

yellow_cab_trips <- cab_data %>% 
  filter(Company == "Yellow Cab") %>%
  group_by(Month) %>%
  summarize(total_trips = n())

# Plot the number of trips per month for each company
ggplot(pink_cab_trips, aes(x = Month, y = total_trips)) +
  geom_line(color = "pink") +
  ggtitle("Pink Cab: Number of Trips per Month") +
  xlab("Month") +
  ylab("Number of Trips")

ggplot(yellow_cab_trips, aes(x = Month, y = total_trips)) +
  geom_line(color = "yellow") +
  ggtitle("Yellow Cab: Number of Trips per Month") +
  xlab("Month") +
  ylab("Number of Trips")


# Calculate the number of trips per month for each company
trips_per_month <- cab_data %>%
  group_by(Company, Month) %>%
  summarize(total_trips = n())

# Plot the number of trips per month for each company
ggplot(trips_per_month, aes(x = Month, y = total_trips, color = Company)) +
  geom_line() +
  ggtitle("Number of Trips per Month") +
  xlab("Month") +
  ylab("Number of Trips") +
  scale_color_manual(values = c("pink", "yellow"))  # Set colors for each company



