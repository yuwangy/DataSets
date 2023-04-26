# load libraries
library(tidyverse)
library(dplyr)
library(lubridate)

# Load the dataset
cab_data <- read.csv("https://raw.githubusercontent.com/yuwangy/DataSets/main/Cab_Data.csv")

# Check the structure of the data
str(cab_data)

# Summary statistics
summary(cab_data)

# Average price charged per city
aggregate(cab_data$Price.Charged, by = list(cab_data$City), FUN = mean)

# Average distance traveled per city
aggregate(cab_data$KM.Travelled, by = list(cab_data$City), FUN = mean)

# Average profit per city
cab_data$Profit <- cab_data$Price.Charged - cab_data$Cost.of.Trip
aggregate(cab_data$Profit, by = list(cab_data$City), FUN = mean)

# Create a histogram of price charged
hist(cab_data$Price.Charged, breaks = 20, xlab = "Price Charged", main = "Histogram of Price Charged")

# Create a scatterplot of distance traveled vs. price charged
plot(cab_data$KM.Travelled, cab_data$Price.Charged, xlab = "Distance Traveled", ylab = "Price Charged", main = "Scatterplot of Distance Traveled vs. Price Charged")

# Check missing value
sum(is.na(cab_data))

# summary for key numeric values
summary(cab_data$KM.Travelled, cab_data$Price.Charged, cab_data$Cost.Of.Trip)

library(ggplot2)

ggplot(cab_data, aes(x = KM.Travelled)) +
  geom_histogram(bins = 50, fill = "blue") +
  labs(x = "Distance Travelled (km)", y = "Count") +
  ggtitle("Distribution of Distance Travelled") +
  theme_minimal()

ggplot(cab_data, aes(x = Price.Charged)) +
  geom_histogram(bins = 50, fill = "blue") +
  labs(x = "Price Charged ($)", y = "Count") +
  ggtitle(("Disbribution of Price Charged")) +
  theme_minimal()

# Filter data for Pink Cab and Yellow Cab
pink_cab_data <- cab_data[cab_data$Company == "Pink Cab",]
yellow_cab_data <- cab_data[cab_data$Company == "Yellow Cab",]







library(dplyr)

# Create a new data frame with the relevant column: profit
profits <- cab_data %>%
  select(Company, Price.Charged, Cost.of.Trip) 

# Calculate profits for each company
pink_cab_data$profit <- pink_cab_data$Price.Charged - pink_cab_data$Cost.of.Trip
yellow_cab_data$profit <- yellow_cab_data$Price.Charged - yellow_cab_data$Cost.of.Trip

# Calculate total profits for each company
total_pink_cab_profit <- sum(pink_cab_data$profit)
total_yellow_cab_profit <- sum(yellow_cab_data$profit)

# Print the total profits made by each company
cat("Total profit made by Pink Cab: $", round(total_pink_cab_profit, 2), "\n")
cat("Total profit made by Yellow Cab: $", round(total_yellow_cab_profit, 2), "\n")

# Plot a bar chart to compare profits
library(ggplot2)
cab_profit <- data.frame(Company=c("Pink Cab", "Yellow Cab"), Profit=c(total_pink_cab_profit, total_yellow_cab_profit))
ggplot(cab_profit, aes(x=Company, y=Profit, fill=Company)) + geom_bar(stat="identity") + 
  ggtitle("Profits: Pink Cab v.s Yellow Cab")


# Create a new data frame with columns for the year, cab company, and profit
library(lubridate)

cab_data$Date <- as.Date(cab_data$Date, origin = "1899-12-29")


yearly_profit <- cab_data %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%Y"), 
         year = year(Date)) %>% 
  group_by(year, Company) %>%
  summarize(profit = sum(Price.Charged - Cost.of.Trip))

# Create bar chart for Pink Cab yearly profits
pink_profit <- yearly_profit %>%
  filter(Company == "Pink Cab")
ggplot(pink_profit, aes(x = year, y = profit)) +
  geom_col(fill = "pink", color = "black") +
  labs(title = "Pink Cab Yearly Profits", x = "Year", y = "Profit")

# Create bar chart for Yellow Cab yearly profits
yellow_profit <- yearly_profit %>%
  filter(Company == "Yellow Cab")
ggplot(yellow_profit, aes(x = year, y = profit)) +
  geom_col(fill = "yellow", color = "black") +
  labs(title = "Yellow Cab Yearly Profits", x = "Year", y = "Profit")



