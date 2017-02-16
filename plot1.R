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

## Get total emissions by year
totalEmissionsByYear <- with(NEI, tapply(Emissions, year, sum))

png("plot1.png")
barplot(totalEmissionsByYear/10^6, names.arg=names(totalEmissionsByYear), 
        ylab="Total PM2.5 (1M Tons)",
        xlab="Years",
        main="USA PM2.5 Emissions from All Sources",
        ylim=range(0:8))
dev.off()
