source("shared.R");

render_plot_2 <- function(data, standalone=TRUE) {
  
  print(sprintf("Rendering plot 2 (standalone: %s)", standalone));

  if(standalone) { start_png_rendering("plot2.png"); }
  
  plot(data$DateTime, data$Global_active_power, type="l", main="", xlab="", ylab="Global Active Power (kilowatts)");
  
  if(standalone) { stop_png_rendering(); }
}

data <- load_data();
render_plot_2(data);
