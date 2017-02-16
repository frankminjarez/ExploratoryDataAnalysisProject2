## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge classification and summary data
NS <- merge(x = NEI, y = SCC, by = "SCC", all.x = TRUE)

NSCoal <- subset(NS, grepl(glob2rx("*Comb*Coal*") , Short.Name))
NSCoalSummary<-ddply(NSCoal,.(year),summarize,total=sum(Emissions))

png("plot4.png")
ggplot(NSCoalSummary, aes(x=as.factor(year), y=total)) + 
        labs(x = "Year") + 
        labs(y="Coal Comb. Total PM25 (Tons)") +
        labs(title="US Coal Emissions") +
        geom_bar(stat="Identity")
dev.off()
