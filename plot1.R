source("shared.R");

render_plot_1 <- function(data, standalone=TRUE) {
  
  print(sprintf("Rendering plot 1 (standalone: %s)", standalone));
  
  if(standalone) { start_png_rendering("plot1.png"); }
  
  hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency");
  
  if(standalone) { stop_png_rendering(); }
}

data <- load_data();
render_plot_1(data);
