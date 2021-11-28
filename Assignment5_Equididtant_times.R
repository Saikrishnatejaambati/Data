setwd("C:/Users/saiki/Documents/Intern/Assignment4")
library(dplyr)
library(chron)

#Reading the trade data into R.
Trades_Aug_26_2009 <- read.table("20090826.trd",sep = "|",header = FALSE, col.names = c("Trade_ID_number","Symbol","Series","Timestamp","Price","Quantity_traded"))

#Initialising the dataframe
Equidistant_times <- data.frame(Price = double(),Time = character(),stringsAsFactors = FALSE)

#Getting the unique elements of the column Symbol
Unique_elements <- unique(Trades_Aug_26_2009$Symbol)

#to choose the stock and the rows of that stock
Choose_stock = 2
df <- filter(Trades_Aug_26_2009, Trades_Aug_26_2009$Symbol == Unique_elements[Choose_stock])

#To convert string into times
df$Timestamp <- chron(times = df$Timestamp)

#A variable that stores 1st time encountered
temp <- df[1,4] 

#time difference
time_difference <- chron(times = "00:02:00")

#To store into data frame
i = 2
indices <- vector()
indices[1] = 0
while(temp <= df[nrow(df),4]) {
  temp2 <- temp + time_difference
  indices[i] <- nrow(filter(df,df$Timestamp-temp2 <=0))
  #inorder to remove repeatitions if time interval is lower 
  if(indices[i] != indices[i-1]) {
    x <- data.frame("Price" = df[indices[i],5],"Time" = df[indices[i],4])
    Equidistant_times <- rbind(Equidistant_times,x)
  }
  temp <- temp2
  i <- i +1
}
#To store into a file
write.table(Equidistant_times,"Equidistant_times.trd",sep = "|",row.names = FALSE)