## Reading of data from dataset provided, assuming the file is saved in the current working directory

file_dir <- './household_power_consumption.txt'
power <- read.table(file_dir, stringsAsFactors = FALSE, header = TRUE, sep =';', na.strings='?', dec='.' )


##Conversion of Date column to date format and combined with Time to form a new colume appended to the original data

power$Date <- as.Date(power$Date, format='%d/%m/%Y')
power <- cbind(power, "DateTime" = as.POSIXct(paste(power$Date, power$Time)))


##Subsetting the collected data dated from 2007/02/01 to 2007/02/02

plot_data <- subset(power, Date=='2007-02-01' | Date=='2007-02-02')


##Conversion of plotting data to numeric format

Global_active_power <- as.numeric(plot_data$Global_active_power)


##Plotting of graph in png device

png('plot2.png', width=480, height=480)
plot(plot_data$Global_active_power ~ plot_data$DateTime, type="l", xlab= "", ylab="Global Active power (kilowatts)")
dev.off()

