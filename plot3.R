plot3 <- function()
{
    ## Read the household power consumption dataset. I kept this as a separate function
    ## for cleanliness and to avoid violating the Single Responsibility Principle 
    data <- readData()
    
    ## Open png file with specified name and dimensions
    png(filename = "plot3.png", width = 480, height = 480)
    
    ## Create the chart with necessary specifications
    with(data, plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
    with(data, lines(Time,Sub_metering_2, col = "red"))
    with(data, lines(Time, Sub_metering_3, col = "blue"))
    legend("topright", pch ="_", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", 
                                                                             "Sub_metering_3"))
    
    ## Close the png file
    dev.off()
}


readData <- function()
{
    ## Import the sqldl package to use SQL to read only the necessary dates
    data <- read.csv.sql("./household_power_consumption.txt", 
                         sql = "select * from file where Date in ('1/2/2007','2/2/2007')", 
                         header = TRUE, sep = ";", connection = NULL)
    
    ## Convert "Time" to POSIXlt class
    data$Time <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
    
    ## Convert "Date" to Date class
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    
    ## "return" statement
    data
}