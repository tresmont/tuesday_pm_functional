
make_pdf <- function(expr, filename, ..., verbose = TRUE) {
  if (verbose) {
    message("Creating: ", filename)
  }
  pdf(file = filename, ...)
  on.exit(dev.off())
  eval.parent(substitute(expr))
}

hist_from_chm <- function(chm, title) {
  hist(chm,
       main = title,
       xlab = "Canopy Height (m)")
}

# a function to plot density of heights with chosen breaks
# expects chm raster, a title, and a vector of breaks
plot_chm_density <- function(rast_in, site.name, bins) {
  density(rast_in,
          main = paste("Canopy Height Density\n", site.name),
          xlab = "Canopy Heights (m)")
  abline(v = bins, col = "red")
}

#############################
# function to create a reclassify matrix from a set of breaks
create_height_class_matrix <- function(breaks) {
  # Get the length of the breaks vector to
  # figure how many classes
  br_len <- length(breaks)
  
  # Initialize height class vector with 0
  height_class_m <- c(0)
  
  # for input of breaks = c(6, 30, 50, 100) we expect:
  # c(0, 6, 1,
  #   6, 30, 2,
  #   30, 50, 3,
  #   50, 100, 4)
  
  for (i in 1:br_len) {
    height_class_m <- c(height_class_m, breaks[i - 1], breaks[i], i)
  }
  
  reclass_height_mat <- matrix(height_class_m,
                               ncol = 3,
                               byrow = TRUE)
  
  return(reclass_height_mat)
}

##########################################
##########################################
# function to plot the reclassified raster

plot_reclassified_raster <- function(rast.in, site.name, breaks){
  # this is a tricky bit because we need to out the legend
  # outside of the plot region
  
  # Get colors for plotting
  bin.colors <- rev(terrain.colors(length(breaks)))
  
  # make room for a legend
  
  par(xpd = FALSE, mar = c(5.1, 4.1, 4.1, 4.5))
  
  # plot
  plot(rast.in,
       col = bin.colors,
       main = paste("Canopy height classes \n", site.name),
       legend = FALSE)
  
  # allow legend to plot outside of bounds
  par(xpd = TRUE)
  
  # legend x
  leg.x <- par()$usr[2] + 20
  
  # legend y
  leg.y <- par()$usr[4] + 50 - (abs(par()$usr[3] - par()$usr[4]) / 2) 
  
  # create legend text
  height.mat <- create_height_class_matrix(breaks)
  
  # initialize legend text
  legend.text <- c()
  
  for (i in 1:length(breaks)) {
    
    legend.text <- c(legend.text, 
                     paste0(height.mat[i, 1], "-", 
                            height.mat[i, 2], " m"))
  }
  
  # create the legend
  legend(leg.x, leg.y,  # set x,y legend location
         legend = legend.text,  # make sure the order matches colors
         fill = bin.colors,
         bty = "n") # turn off border
  
  # turn off plotting outside of bounds
  par(xpd = FALSE)
}