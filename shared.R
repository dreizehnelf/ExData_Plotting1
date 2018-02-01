DATASET_FILE <- "household_power_consumption.txt";
SUBSETTED_DATASET_FILE <- "household_power_consumption.subsetted.txt";
DATASET_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# check, if the data exists
is_dataset_available <- function() {
  return(file.exists(DATASET_FILE));
}

download_and_extract_file <- function() {
  
  if(is_dataset_available()) {
    print(sprintf("Dataset '%s' is already there. Skipping download.", DATASET_FILE));
    return(FALSE);
  }
  
  print(sprintf("Downloading dataset from '%s'.", DATASET_URL));
  
  # generate a temp file name for the download
  temp_file_name <- tempfile("dataset_download");
  
  # download the file
  download.file(DATASET_URL, temp_file_name);
  
  # extract it
  unzip(temp_file_name);
  
  # and remove it again
  unlink(temp_file_name);
  
  return(TRUE);
}

save_data <- function(data, file) {
  
  # create directories if not present
  target_dir <- dirname(file);
  
  if(!dir.exists(target_dir)) {
    dir.create(target_dir, recursive=TRUE);
  }
  
  write.table(data, file, sep="\t", row.names=FALSE);
}

load_data <- function() {
  
  # see, if we already have a saved version
  if(!file.exists(SUBSETTED_DATASET_FILE)) {
    print("Subsetted data file does not exist yet, generating it...");

    # make sure, the data is there
    download_and_extract_file();
    
    # load the data
    dataset <- read.table(
      DATASET_FILE,
      header=TRUE,
      sep=";",
      colClasses=c(
        rep("character", 2),
        rep("numeric", 7)
      ),
      na.strings="?"
    );
  
    # filter out just the dates we are interested in
    dataset <- dataset[dataset$Date %in% c('1/2/2007', '2/2/2007'),]
    
    # convert dates and times into proper classes, so handling is easier
    dataset$DateTime <- strptime(
      paste(dataset$Date, dataset$Time, sep=" "),
      format="%d/%m/%Y %H:%M:%S"
    );

    # save our subsetted data out to a file, so we can use it instead of always pulling the full file
    save_data(dataset, SUBSETTED_DATASET_FILE);
    
    # return the data
    return(dataset);
    
  } else {
    print("Subsetted data file already exists. Skipping generation.");
    dataset <- read.table(
      SUBSETTED_DATASET_FILE,
      sep="\t",
      header=TRUE
    );
    
    # make sure our DateTime column is of POSIXct type for easier manipulation
    dataset$DateTime <- as.POSIXct(dataset$DateTime, format="%Y-%m-%d %H:%M:%S");
    
    return(dataset);
  }
}

start_png_rendering <- function(filename) {
  png(filename = filename, width = 480, height = 480, units = "px");
}

stop_png_rendering <- function() {
  dev.off();
}
