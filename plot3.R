source("shared.R");

render_plot_3 <- function(data, standalone=TRUE, legend_box_border=TRUE) {
  
  print(sprintf("Rendering plot 3 (standalone: %s)", standalone));
  
  if(standalone) { start_png_rendering("plot3.png"); }
  
  # render our data
  plot(data$DateTime, data$Sub_metering_1, type="l", main="", xlab="", ylab="Energy sub metering");
  lines(data$DateTime, data$Sub_metering_2, type="l", col="red");
  lines(data$DateTime, data$Sub_metering_3, type="l", col="blue");
  
  # add the legend
  legend_labels <- names(data)[7:9];
  if(legend_box_border) {
    legend_box_border_type <- "o";
  } else {
    legend_box_border_type <- "n";
  }
  legend("topright", legend = legend_labels, col=c("black", "red", "blue"), lwd = 1, bty=legend_box_border_type);
  
  if(standalone) { stop_png_rendering(); }
}

data <- load_data();
render_plot_3(data);
