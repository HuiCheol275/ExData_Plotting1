library(data.table)

#data load
data <- fread("household_power_consumption.txt", 
              sep = ";", 
              na.strings = "?", 
              data.table = TRUE,
              colClasses = c("character", "character", 
                             "numeric", "numeric", "numeric", 
                             "numeric", "numeric", "numeric", "numeric"))

# conversion date and filtering
data[, Date := as.Date(Date, format = "%d/%m/%Y")]
filtered_data <- data[Date == "2007-02-01" | Date == "2007-02-02"]

#create DateTime value
filtered_data[, DateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

#plot2.R
png("plot2.png", width = 480, height = 480)
plot(filtered_data$DateTime, as.numeric(filtered_data$Global_active_power), 
     type = "l", 
     xlab = "Date", 
     ylab = "Global Active Power (kilowatts)", 
     main = "Global Active Power over Time",
     xaxt = "n")

# add to day
axis(1, at=seq(from = min(filtered_data$DateTime),
               to = max(filtered_data$DateTime),
               length.out = 3), labels = c("Thu", "Fri", "Sat"))

dev.off() # save to PNG file

