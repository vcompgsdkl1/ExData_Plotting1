#
# plot1.R
# Build a histogram of Global Active Power
#

makePlot1 <- function(pwr, outfile) {
  # Create Plot 1
  # Create a historgram of global active power.
  # Use default bins for historgram (bucket 4 kind of ends at 2).
  # Be explicit about size even though 480x480 is the default.
  #
  # Args:
  #  pwr     : power usage data set to plot
  #  outfile : path to png file to produce
  # 
  png(filename = outfile, width = 480, height=480)
  hist(pwr$GlobalActivePower, col="red", main="Global Active Power",
       xlab="Global Active Power (kilowatts)")
  dev.off()
}

source("c:/users/user/c4w1/dataUtil.R")
data <- courseData()
if (! file.exists("c:/users/user/c4w1/img")) { dir.create("c:/users/user/c4w1/img") }
makePlot1(data$get(), "c:/users/user/c4w1/img/plot1.png")


