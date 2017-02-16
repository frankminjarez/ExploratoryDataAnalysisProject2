library(plyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset of Baltimore City Data
bc <- subset(NEI,fips==24510)

## Group by year and type, sum Emissions
bcByTypeAndYear<-ddply(bc,.(year, type),summarize,total=sum(Emissions))

png("plot3.png")
ggplot(bcByTypeAndYear, aes(x=year, y=total, fill=type)) + 
        labs(x = "Year") + 
        labs(y="Total PM25 (Tons)") +
        labs(title="Emissions by Type for Baltimore City") +
        geom_bar(stat="Identity",position="dodge")
dev.off()
