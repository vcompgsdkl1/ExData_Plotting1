#
# dataUtil.R
#
# useful data and file routines that all 4 plots need, that don't make
# sense to write 4 times.

fetchFile <- function(srcURL, fileName, dataDir = "c:/users/user/c4w1/data") {
  # Fetch a data file from a url
  #
  # Args:
  #  srcURL   : url of the origional data source
  #  fileName : local name for the data file
  #  dataDir  : path to the data directory, default ./data
  #
  # Return    : path to the downloaded file
  #
  
  if (! file.exists(dataDir)) {
    dir.create(dataDir)
  }

  filePath <- file.path(dataDir, fileName)
  if (! file.exists(filePath)) {
    download.file(srcURL, filePath, method="curl")
  }
  filePath
}


extractFile <- function(zipPath, fileName, workDir) {
  unzip(zipPath, fileName, exdir = workDir)
  file.path(workDir, fileName)
}

courseData <- function() {
  # Load and process the data set, caching it to avoid reloads
  # on various graphs, and such.
  #
  # Args: N/A
  # Return : list of accessor/mutator functions
  
  # constants we just kind of know
  courseDir <- "https://d396qusza40orc.cloudfront.net/exdata/data"
  zipFile <- "household_power_consumption.zip"
  txtFile <- "household_power_consumption.txt"

  # cached copy of the power consumption data set we are interested in
  pwr <- NULL

  reset <- function() {
    # flush the cache and force a reload
    # Args: N/A
    # Return : N/A
    
    pwr <<- NULL
  }

  get <- function() {
    #
    # Get the data set.  Data set returned is a data frame,
    # limtied to only data for 2/1 and 2/2 2007, with
    # the Date and Time colums transformed into a single Date
    # called Timestamp and all other data colums unmodified from
    # the origional UCI data.
    #
    # Args: N/A
    # Return: data.frame as described above
    
    # use the cached copy if possible
    if (! is.null(pwr)) {
      return(pwr)
    }

    # otherwise go load and process it
    ## src <-file.path(courseDir, zipFile)
    ## archive <- fetchFile(src, zipFile, "c:/users/user/c4w1/data")
    ## input <- extractFile(archive, txtFile, "c:/users/user/c4w1/data")

    input <-  "c:/users/user/c4w1/data/household_power_consumption.txt"
    
    allData <- read.table(input, header = TRUE, sep=";", na.strings="?",
                          col.names = c("Date", "Time", "GlobalActivePower",
                            "GlobalReactivePower", "Voltage", "GlobalIntensity",
                            "Submetering1", "Submetering2", "Submetering3"),
                          colClasses = c( "character", "character", "numeric",
                            "numeric", "numeric", "numeric", "numeric",
                            "numeric", "numeric"))
    pwr <<- with(subset(allData, Date == "1/2/2007" | Date == "2/2/2007"),
                 data.frame(Timestamp = strptime(paste(Date, Time),
                              format="%d/%m/%Y %H:%M:%S"),
                            GlobalActivePower, GlobalReactivePower, Voltage,
                            GlobalIntensity, Submetering1, Submetering2,
                            Submetering3))
    # return the copy we just saved
    pwr
  }
  
  list(reset = reset, get = get)
}
