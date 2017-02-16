## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge classification and summary data
NS <- merge(x = NEI, y = SCC, by = "SCC", all.x = TRUE)

NSBc <- subset(NS,fips==24510)
NSBc <- subset(NSBc,grepl("Mobile*", SCC.Level.One))
NSBc <- subset(NSBc,grepl("*Vehicle*", SCC.Level.Two))
VehicleByYear<-ddply(NSBc,.(year),summarize,total=sum(Emissions))

png("plot5.png")                                                    
ggplot(VehicleByYear, aes(x=as.factor(year), y=total)) + 
        labs(x = "Year") + 
        labs(y="Vehicle Comb. Total PM25") +
        labs(title="Baltimore City Vehicle Emissions") +
        geom_bar(stat="Identity")

dev.off()