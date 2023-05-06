library(dplyr)

# Load the cab_data and customer_id data sets
cab_data <- read.csv("https://raw.githubusercontent.com/yuwangy/DataSets/main/Cab_Data.csv")
customer_id <- read.csv("https://raw.githubusercontent.com/yuwangy/DataSets/main/Customer_ID.csv")

cab_data$Date <- as.Date(cab_data$Date, origin = "1899-12-29")

# Create age groups based on the age of the customers
cab_data_age <- cab_data %>%
  mutate(Age = 2023 - year(as.Date(Date))) %>%
  mutate(Age_Group = case_when(Age <= 18 ~ "Under 18",
                               Age <= 25 ~ "18-25",
                               Age <= 35 ~ "26-35",
                               Age <= 50 ~ "36-50",
                               Age > 50 ~ "Over 50",
                               TRUE ~ "Unknown"))

# Join the two data sets based on Customer ID
cab_data_age <- left_join(cab_data_age, customer_id, by = "Customer ID")

# Calculate the profits for each ride
cab_data_age <- cab_data_age %>%
  mutate(profit = `Price Charged` - `Cost of Trip`)

# Group the data by cab type, age group, and profit
cab_data_age_summary <- cab_data_age %>%
  group_by(`Company`, Age_Group) %>%
  summarize(total_profit = sum(profit),
            total_customers = n_distinct(`Customer ID`))

# Plot the results
library(ggplot2)

ggplot(cab_data_age_summary, aes(x=`Company`, y=total_profit, fill=Age_Group)) +
  geom_bar(stat="identity", position="dodge") +
  ggtitle("Total Profits by Cab Type and Age Group") +
  xlab("Cab Type") +
  ylab("Total Profit") +
  scale_fill_manual(values = c("#1f78b4", "#33a02c", "#fb9a99", "#e31a1c", "#fdbf6f", "#a6cee3")) +
  theme(legend.position = "bottom")

ggplot(cab_data_age_summary, aes(x=`Company`, y=total_customers, fill=Age_Group)) +
  geom_bar(stat="identity", position="dodge") +
  ggtitle("Total Customers by Cab Type and Age Group") +
  xlab("Cab Type") +
  ylab("Total Customers") +
  scale_fill_manual(values = c("#1f78b4", "#33a02c", "#fb9a99", "#e31a1c", "#fdbf6f", "#a6cee3")) +
  theme(legend.position = "bottom")
