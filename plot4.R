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


##Plotting of multilines graph in png device

png('plot4.png', width=480, height=480)
par(mfcol=c(2,2))  ##define the graphs arrangement (2X2)

plot(plot_data$Global_active_power ~ plot_data$DateTime, type="l", xlab='',ylab='Global Active Power' ) 				##graph(1,1)

plot(plot_data$Sub_metering_1 ~ plot_data$DateTime, type="l", xlab='',ylab='Energy Submetering')					##graph(2,1)
lines(plot_data$Sub_metering_2 ~ plot_data$DateTime, col = 'Red')											##graph(2,1)
lines(plot_data$Sub_metering_3 ~ plot_data$DateTime, col = 'Blue')										##graph(2,1)
legend('topright', bty='n', col=c('black', 'red', 'blue') ,legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')) 	##legends for graph(2,1)
		
plot(plot_data$Voltage ~ plot_data$DateTime, type="l", xlab='datetime',ylab='Voltage')							##graph(1,2)
plot(plot_data$Global_reactive_power ~ plot_data$DateTime, type="l", xlab='datetime',ylab='Global_reactive_power')		##graph(2,2)

dev.off()