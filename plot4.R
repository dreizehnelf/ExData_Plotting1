source("shared.R");
source("plot2.R");
source("plot3.R");

render_plot_4 <- function(data, standalone=TRUE) {
  
  print(sprintf("Rendering plot 4 (standalone: %s)", standalone));
  
  if(standalone) { start_png_rendering("plot4.png"); }
  
  # we want a 2x2 grid of plots
  par(mfrow=c(2,2));
  
  # Plot 2 in top left
  render_plot_2(data, standalone=FALSE);
  
  # Voltage by datetime in top right
  plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage");
  
  # Plot 3 without legend border in bottom left
  render_plot_3(data, standalone=FALSE, legend_box_border=FALSE);
  
  # Global reactive power by datetime in bottom right
  plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power");
  
  if(standalone) { stop_png_rendering(); }
}

data <- load_data();
render_plot_4(data);
