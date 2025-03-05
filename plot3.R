library(data.table)

# data load
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

# create DateTime value
filtered_data[, DateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

# missing value check and omit
clean_data <- na.omit(filtered_data)

# plot3.R
png("plot3.png", width = 480, height = 480)

# create default plot
plot(clean_data$DateTime, as.numeric(clean_data$Sub_metering_1), 
     type = "l", 
     col = "black", 
     xlab = "Date", 
     ylab = "Energy sub metering", 
     ylim = c(0, 40), 
     main = "Energy sub metering",
     xaxt = "n")  # don't use default x label

# add to sub metering data
lines(clean_data$DateTime, as.numeric(clean_data$Sub_metering_2), col = "red")
lines(clean_data$DateTime, as.numeric(clean_data$Sub_metering_3), col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

# add to day
axis(1, 
     at = seq(from = min(clean_data$DateTime), 
              to = max(clean_data$DateTime), 
              length.out = 3), 
     labels = c("Thu", "Fri", "Sat"))

dev.off()  # save to PNG file
