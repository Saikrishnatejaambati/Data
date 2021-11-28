setwd("C:/Users/saiki/Documents/Intern/Assignment4")
library(dplyr)

#Reading the trade data into R.
Trades_Aug_26_2009 <- read.table("20090826.trd",sep = "|",header = FALSE, col.names = c("Trade_ID_number","Symbol","Series","Timestamp","Price","Quantity_traded"))

#Creating the required file
#Initialising the dataframe
Trade_summary <- data.frame(Symbol = character(),WeightedAveragePrice = double(),stringsAsFactors=FALSE)

#Getting the unique elements of the column Symbol
Unique_elements <- unique(Trades_Aug_26_2009$Symbol)

#Finding the values of Weighted Average Price for each symbol
for (i in (1: length(Unique_elements))) {
  i = 1
  df <- filter(Trades_Aug_26_2009, Trades_Aug_26_2009$Symbol == Unique_elements[i])
  x <- data.frame("Symbol" = Unique_elements[i],"WeightedAveragePrice" = sum(df$Price * df$Quantity_traded)/sum(df$Quantity_traded) )
  Trade_summary <- rbind(Trade_summary,x)
}

#Storing it into a file named as Trade_summary.trd
write.table(df,"df.trd",sep = "|",row.names = FALSE)
