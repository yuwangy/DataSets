# data cleaning and wrangling on cab company performance

Cab_Data <- read_csv("DataSets/Cab_Data.csv")

Cab_Data[order(Cab_Data$`KM Travelled`, Cab_Data$`Date of Travel`),]
arrange(Cab_Data, Company, `Price Charged`)
arrange(Cab_Data, `Date of Travel`)
figure1 <- select(Cab_Data, Company,`KM Travelled`, `Price Charged`)

figure1
select(figure1, Company, starts_with("Yellow Cab"))
Cab_Data

#. group and summarize
Cab_Data %>%
  group_by(Company) %>%
  summarize(mn = mean(`Price Charged`), na.rm = TRUE)

figure2 <- ggplot(Cab_Data, aes(x = `KM Travelled`, y = `Price Charged`)) +
  geom_bar(stat = "identity") +
  xlab("KM travelled by cab") +
  ylab("Price charged to customoers")

figure2

Cab_Data %>%
  group_by(Company, `Price Charged`) %>%
  summarize(profit = sum(`Price Charged`)) %>%
  spread(`Price Charged`, profit)











  





