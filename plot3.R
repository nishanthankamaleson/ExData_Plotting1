# load the required libraries
library(data.table)

# read the data
df <- fread('household_power_consumption.txt',sep = ';', na.strings = '?')

# convert the Date column
df$Date <- as.Date(df$Date, format='%d/%m/%Y')

# subset the df between Date 2007-02-01 and 2007-02-02
start <- as.Date("2007-02-01")
end <- as.Date("2007-02-02")
subdf <- subset(df, Date >= start & Date<=end)

# open PNG device and create 'plot1.r' in the current working directory.
png(filename = "plot3.png", width=480, height=480)

# merge date and time
datetime <- as.POSIXct(paste(subdf$Date, subdf$Time), 
                     format='%Y-%m-%d %H:%M:%S')

# plot line graph
plot(x = datetime, 
     y=subdf$Sub_metering_1, 
     xlab = "",
     ylab = 'Energy sub metering',
     type = "l")

# plot on top of the same graph
lines(x=datetime,
     y=subdf$Sub_metering_2,
     type='l',
     col='red')

# plot on top of the same graph
lines(x=datetime,
      y=subdf$Sub_metering_3,
      type='l',
      col='blue')

# add legend
legend('topright', 
       c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty = 1,
       lwd = 2,
       col=c('black', 'red', 'blue'))

# close the device
dev.off()

