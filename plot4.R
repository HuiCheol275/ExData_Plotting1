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

#create DateTime value
filtered_data[, DateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

# missing value check and omit
clean_data <- na.omit(filtered_data)

# plot setting
png("plot4.png", width = 800, height = 800)
par(mfrow = c(2, 2))  # 2row 2col plot deployment

# 1. Global Active Power
plot(clean_data$DateTime, as.numeric(clean_data$Global_active_power), 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power", 
     main = "", 
     xaxt = "n")

# add to day
axis(1, 
     at = seq(from = min(clean_data$DateTime), 
              to = max(clean_data$DateTime), 
              length.out = 3), 
     labels = c("Thu", "Fri", "Sat"))

# 2. Voltage
plot(clean_data$DateTime, as.numeric(clean_data$Voltage), 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage", 
     main = "", 
     xaxt = "n")

# add to day
axis(1, 
     at = seq(from = min(clean_data$DateTime), 
              to = max(clean_data$DateTime), 
              length.out = 3), 
     labels = c("Thu", "Fri", "Sat"))

# 3. Energy sub metering
plot(clean_data$DateTime, as.numeric(clean_data$Sub_metering_1), 
     type = "l", 
     col = "black", 
     xlab = "", 
     ylab = "Energy sub metering", 
     ylim = c(0, 40),
     xaxt = "n")
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

# 4. Global Reactive Power
plot(clean_data$DateTime, as.numeric(clean_data$Global_reactive_power), 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power", 
     main = "", 
     xaxt = "n")
# add to day
axis(1, 
     at = seq(from = min(clean_data$DateTime), 
              to = max(clean_data$DateTime), 
              length.out = 3), 
     labels = c("Thu", "Fri", "Sat"))

dev.off()  # save to PNG file
