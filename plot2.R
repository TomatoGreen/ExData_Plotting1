drawPlot2<-function(){
  resetWorkDir()
  #loadData()
  dataSet<-readData()
  plot2(dataSet)
}

resetWorkDir<-function(){
  ## set work directory
  wd<-"~/Documents/Coursera/Data Science Specialization/04-Exploratory_Data_Analysis/cp1"
  setwd(wd)
  if(!file.exists("data")){
    dir.create("data")
  }
}
loadData<-function(){
  ## download data and unzip the data to course project data folder
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  filePath <- "./data/data.zip"
  download.file(fileUrl, destfile=filePath, method="curl")
  unzip(filePath, exdir="./data", overwrite = TRUE)
}

readData<-function(){
  dataFile<-"./data/household_power_consumption.txt"
  naValues<-c("?")
  columnClasses<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
  df<-read.table(dataFile, header=TRUE, sep=";", dec=".", na.strings = naValues,colClasses = columnClasses)
  filterValues<-c("1/2/2007","2/2/2007")
  df<-df[df$Date %in% filterValues, ]
  return (df)
}

plot2<-function(d){
  globalActivePower<-d$Global_active_power
  dt <- strptime(paste(d$Date, d$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  png("plot2.png", width=480, height=480)
  plot(dt, globalActivePower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  dev.off()
}