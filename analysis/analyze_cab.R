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


