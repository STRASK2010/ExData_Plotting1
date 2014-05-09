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

## plot histogram of Global active power
png(file=file.path(project_path, "plot1.png"), width=480, height=480)
hist(dat$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()
