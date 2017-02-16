url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if(!file.exists("emissions.zip")) {
        download.file(url, "emissions.zip")
}

if(!file.exists("summarySCC_PM25.rds")) {
        unzip("emissions.zip")
}

library(plyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset of Baltimore City Data
bc <- subset(NEI,fips==24510)

## Group by year and type, sum Emissions
bcByTypeAndYear<-ddply(bc,.(year, type),summarize,total=sum(Emissions))

png("plot3.png")
g <- ggplot(bcByTypeAndYear, aes(x=as.factor(year), y=total, fill=type)) + 
        labs(x = "Year") + 
        labs(y="Total PM25 (Tons)") +
        labs(title="Emissions by Type for Baltimore City") +
        geom_bar(stat="Identity",position="dodge")
print(g)
dev.off()

png("plot3_1.png")
g <- ggplot(bcByTypeAndYear, aes(year, total, color = type)) + 
        geom_line(size = 1.5) +
        xlab("year") +
        ylab("Total emissions")
print(g)
dev.off()
