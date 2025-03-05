library(data.table)

# data load
data <- fread("household_power_consumption.txt", 
              sep = ";", na.strings = "?", 
              data.table = TRUE, 
              colClasses = c("character", "character", 
                             "numeric", "numeric", "numeric", 
                             "numeric", "numeric", "numeric", "numeric"))

# conversion date and filtering
data[, Date := as.Date(Date, format = "%d/%m/%Y")]
filtered_data <- data[Date == "2007-02-01" | Date == "2007-02-02"]

# plot3.R
png("plot1.png", width = 480, height = 480)
hist(as.numeric(filtered_data$Global_active_power), 
         main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)", 
         col = "red", breaks = 30)

dev.off() # save to PNG file