#
# plot2.R
# Build a plot of Global Active Power over time
#

makePlot2 <- function(pwr, outfile) {
  # Create Plot 2
  # Draw a xy line chart, of Global Active Power vs Time
  # over the two day period.
  #
  # Args:
  #  pwr     : power usage data set to plot
  #  outfile : file to save the png as
  
  png(filename = outfile, width = 480, height=480)
  plot(pwr$Timestamp, pwr$GlobalActivePower, type="l",
       xlab="", ylab="Global Active Power (kilowatts)")
  dev.off()
}

source("c:/users/user/c4w1/dataUtil.R")
data <- courseData()
if (! file.exists("c:/users/user/c4w1/img")) { dir.create("c:/users/user/c4w1/img") }
makePlot2(data$get(), "c:/users/user/c4w1/img/plot2.png")
