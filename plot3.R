#
# plot3.R
# Build a plot of energy use for each sub metered zone over time
#

makePlot3 <- function(pwr, outfile) {
  # Create Plot 3
  # Draw a xy line chart, of power consumption in
  # each of the three sub metered zones over Time
  # for the two day period
  #
  # Args:
  #  pwr     : power usage data set to plot
  #  outfile : file to save the png as
  
  png(filename = outfile, width = 480, height=480)

  # build the empty base plot from submetering 1.  It's first,
  # and it's biggest,  but really should plot max(submetering 1/2/3)
  # to scale things right
  plot(pwr$Timestamp, pwr$Submetering1, type="n", xlab="",
       ylab="Energy sub metering")
  points(pwr$Timestamp, pwr$Submetering1, type="l", col="black")
  points(pwr$Timestamp, pwr$Submetering2, type="l", col="red")
  points(pwr$Timestamp, pwr$Submetering3, type="l", col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}

source("c:/users/user/c4w1/dataUtil.R")
data <- courseData()
if (! file.exists("c:/users/user/c4w1/img")) { dir.create("c:/users/user/c4w1/img") }
makePlot3(data$get(), "c:/users/user/c4w1/img/plot3.png")
