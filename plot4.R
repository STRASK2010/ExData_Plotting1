## read in raw data
project_path = file.path(Sys.getenv("HOME"), "R Programming/ExData_Plotting1")

url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url, destfile = file.path(project_path, 'data.csv'))

data_path = file.path(project_path, "data.csv")

df = read.csv(data_path, sep=";", stringsAsFactors=FALSE, header=TRUE,
              na.strings="?")
dim(df); str(df)

## combine Date and Time 
df$datetime = paste(df$Date, df$Time)

## convert datetime from charater type to POSIXlt type
df$datetime = strptime(df$datetime, format="%d/%m/%Y %H:%M:%S")

## subset rows between 2007-02-01 and 2007-02-02
begin = strptime("2007-02-01", format="%Y-%m-%d")
end = strptime("2007-02-03", format="%Y-%m-%d")

dat = subset(df, datetime>=begin & datetime<end)
dim(dat)
head(dat)

## save dat as .rda
save(dat, file=file.path(project_path, "dat.rda"))

load(file.path(project_path, "dat.rda"))

str(dat)

## plot 4 time series plots in one screen
png(file=file.path(project_path, "plot4.png"), width=480, height=480)
par(mfrow = c(2,2)) # divide the screen in 2x2 grids

plot(dat$datetime, dat$Global_active_power, type="l", main="", xlab="",
     ylab="Global Active Power (kilowatts)")

plot(dat$datetime, dat$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(dat$datetime, dat$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(dat$datetime, dat$Sub_metering_2, type="l", col="red")
lines(dat$datetime, dat$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(dat$datetime, dat$Global_reactive_power, type="l", xlab="datetime",
     ylab="Global_reactive_power")

dev.off()