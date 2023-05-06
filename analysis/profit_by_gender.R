library(dplyr)
library(tidyverse)
library(lubridate)

# Load the cab_data and customer_id data sets
cab_data <- read.csv("https://raw.githubusercontent.com/yuwangy/DataSets/main/Cab_Data.csv")
customer_id <- read.csv("https://raw.githubusercontent.com/yuwangy/DataSets/main/Customer_ID.csv")

str(cab_data)
str(customer_id)

cab_data_gender <- left_join(cab_data, customer_id, by = "Customer.ID")

# Calculate the profits for each ride
cab_data <- cab_data %>%
  mutate(profit = Price.Charged - Cost.of.Trip)

# Separate the data by cab type and gender
pinkcab_gender_profit <- cab_data %>%
  filter(Company == "Pink Cab") %>%
  group_by(Gender) %>%
  summarize(profit = sum(profit))

yellowcab_gender_profit <- cab_data %>%
  filter(Company == "Yellow Cab") %>%
  group_by(Gender) %>%
  summarize(profit = sum(profit))

# Combine the data for comparison
combined_gender_profit <- bind_rows(pinkcab_gender_profit, yellowcab_gender_profit, .id = "cab_type")

# Plot the results
library(ggplot2)

ggplot(combined_gender_profit, aes(x=cab_type, y=profit, fill=Gender)) +
  geom_bar(stat="identity", position="dodge") +
  ggtitle("Total Profits by Cab Type and Gender") +
  xlab("Cab Type") +
  ylab("Total Profit") +
  scale_fill_manual(values = c("#1f78b4", "#33a02c")) # blue and green colors for the bars





































# Remove missing data from Customer ID column
# customer_id <- customer_id %>% drop_na(`Customer ID`)

# Join the two data sets based on Customer ID
cab_data_gender <- left_join(cab_data, customer_id, by = Customer.ID)
pinkcab_gender_profit <- cab_data %>%
  filter(Company == "Pink Cab") %>%
  group_by(Gender) %>%
  summarize(profit = sum(`Price Charged` - `Cost of Trip`))

yellowcab_gender_profit <- cab_data %>%
  filter(Company == "Yellow Cab") %>%
  group_by(Gender) %>%
  summarize(profit = sum(`Price Charged` - `Cost of Trip`))

















# Calculate the profits for each ride
# cab_data_gender <- cab_data_gender %>%
#   mutate(profit = `Price Charged` - `Cost of Trip`)
# 
# # Group the data by cab type and gender
# cab_data_gender_summary <- cab_data_gender %>%
#   group_by(`Company`, Gender) %>%
#   summarise(total_profit = sum(profit))
# 
# # Plot the results
# library(ggplot2)
# 
# ggplot(cab_data_gender_summary, aes(x=`Company`, y=total_profit, fill=Gender)) +
#   geom_bar(stat="identity", position="dodge") +
#   ggtitle("Total Profits by Cab Type and Gender") +
#   xlab("Cab Type") +
#   ylab("Total Profit") +
#   scale_fill_manual(values = c("#1f78b4", "#33a02c")) # blue and green colors for the bars
