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

library(plyr)
library(ggplot2)

## Merge classification and summary data
NS <- merge(x = NEI, y = SCC, by = "SCC", all.x = TRUE)

NSBc <- subset(NS,fips %in% c("24510", "06037"))
NSBc <- subset(NSBc,grepl("Mobile*", SCC.Level.One))
NSBc <- subset(NSBc,grepl("*Vehicle*", SCC.Level.Two))
vehicleByYear<-ddply(NSBc,.(year,fips),summarize,total=sum(Emissions))
vehicleByYear$city <- ifelse(vehicleByYear$fips == "24510", "Baltimore", "Los Angeles")
png("plot6.png")                                                    
g <- ggplot(vehicleByYear, aes(x=as.factor(year), y=total, fill=city)) + 
        labs(x = "Year") + 
        labs(y="Vehicle Comb. Total PM25") +
        labs(title="Baltimore Vs. Los Angeles Vehicle Emissions") +
        geom_bar(stat="Identity", position="dodge")
print(g)
dev.off()
