#
# plot4.R
# Build a plots of Global Active Power, Sub-Metered Power, Voltage,
# and Global Reactive Power over time.
#

makePlot4 <- function(pwr, outfile) {
  # Create Plot 4
  # Draw four charts in a 2x2 grid:
  #   Global Active Power vs Time
  #   Submetered Power vs Time
  #   Voltage vs Time
  #   Global Reactive Power vs time
  # Args:
  #  pwr     : power usage data set to plot
  #  outfile : file to save the png as
  
  png(filename = outfile, width = 480, height=480)
  # set up a 2x2 grid
  par(mfcol=c(2,2))
  # just plot2 again!
  plot(pwr$Timestamp, pwr$GlobalActivePower, type="l",
       xlab="", ylab="Global Active Power")
  # and plot 3 again
  plot(pwr$Timestamp, pwr$Submetering1, type="n", xlab="",
       ylab="Energy sub metering")
  points(pwr$Timestamp, pwr$Submetering1, type="l", col="black")
  points(pwr$Timestamp, pwr$Submetering2, type="l", col="red")
  points(pwr$Timestamp, pwr$Submetering3, type="l", col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  # Now voltage
  plot(pwr$Timestamp, pwr$Voltage, type="l",
       xlab="datetime", ylab="Voltage")
  
  # and now reactive Power
  # with a real ugly label (per spec)
  plot(pwr$Timestamp, pwr$GlobalReactivePower, type="l",
       xlab="datetime", ylab="Global_reactive_power")
  dev.off()
}

source("c:/users/user/c4w1/dataUtil.R")
data <- courseData()
if (! file.exists("c:/users/user/c4w1/img")) { dir.create("c:/users/user/c4w1/img") }
makePlot4(data$get(), "c:/users/user/c4w1/img/plot4.png")
