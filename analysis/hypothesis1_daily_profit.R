library(dplyr)
library(tidyverse)
library(lubridate)

# Load the cab_data and customer_id data sets
cab_data <- read.csv("https://raw.githubusercontent.com/yuwangy/DataSets/main/Cab_Data.csv")
customer_id <- read.csv("https://raw.githubusercontent.com/yuwangy/DataSets/main/Customer_ID.csv")

cab_data$Date <- as.Date(cab_data$Date, origin = "1899-12-29")
str(cab_data)

# Filter the cab data by Company and group by Date
pink_cab_daily_profit <- cab_data %>%
  filter(Company == "Pink Cab") %>%
  group_by(Date) %>%
  summarize(daily_profit = sum(Price.Charged - Cost.of.Trip))

yellow_cab_daily_profit <- cab_data %>%
  filter(Company == "Yellow Cab") %>%
  group_by(Date) %>%
  summarize(daily_profit = sum(Price.Charged - Cost.of.Trip))


library(ggplot2)

# Plot daily profit over time for each company
ggplot(pink_cab_daily_profit, aes(x = Date, y = daily_profit)) +
  geom_line() +
  ggtitle("Pink Cab Daily Profit") +
  xlab("Date") +
  ylab("Profit")

ggplot(yellow_cab_daily_profit, aes(x = Date, y = daily_profit)) +
  geom_line() +
  ggtitle("Yellow Cab Daily Profit") +
  xlab("Date") +
  ylab("Profit")


