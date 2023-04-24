# data cleaning and wrangling on cab company performance

Cab_Data[order(Cab_Data$`KM Travelled`, Cab_Data$`Date of Travel`),]
arrange(Cab_Data, Company, 'Price Charged')
arrange(Cab_Data, 'Data of Travel')
figure1 <- select(Cab_Data, Company,'KM Travelled', 'Price Charged')
figure1
select(figure1, Company, starts_with("Yellow Cab"))
