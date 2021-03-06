url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if(!file.exists("emissions.zip")) {
        download.file(url, "emissions.zip")
}

if(!file.exists("summarySCC_PM25.rds")) {
        unzip("emissions.zip")
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Get Baltimore City Data
bc <- subset(NEI,fips==24510)

## Get Emissions by Year
totalEmissionsByYear <- with(bc, tapply(Emissions, year, sum))

png("plot2.png")
barplot(totalEmissionsByYear, names.arg=names(totalEmissionsByYear),
     ylab="PM2.5 (Tons)",
     xlab="Years",
     main="Baltimore City PM2.5 Emissions")
dev.off()
