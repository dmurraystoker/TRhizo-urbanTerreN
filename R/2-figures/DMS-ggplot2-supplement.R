#=========================================================================#
#                           ggplot2-supplement                            #
#=========================================================================#

# Functions and figure parameters to accompany ggplot2 for figure creation.

# Author: David Murray-Stoker (dstoker92@gmail.com)
# Last Updated: 31 March 2020

#==========================================================================
#                      Graphical Parameters & Functions                   #
#=========================================================================#
require(calecopal)
require(colorspace)
require(cowplot)
require(ggplot2)
require(ggpubr)
require(grid)
require(gridExtra)
require(gtable)
require(patchwork)
require(RColorBrewer)
require(viridis)
require(viridisLite)
require(wesanderson)


#--------------------------------------------------------------------------
#                               Functions                                 #
#-------------------------------------------------------------------------#

## DEPRECATED: Use grid.arrange instead

## Create multi-panel figures (when figure legend, if applicable, can be 
## be assigned to a figure)
#multiplot <- function(..., plotlist = NULL, file, cols = 1, layout = NULL) {
#  library(grid)
#  
#  # Make a list from the ... arguments and plotlist
#  plots <- c(list(...), plotlist)
#  
#  numPlots = length(plots)
#  
#  # If layout is NULL, then use 'cols' to determine layout
#  if (is.null(layout)) {
#    # Make the panel
#    # ncol: Number of columns of plots
#    # nrow: Number of rows needed, calculated from # of cols
#    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
#                     ncol = cols, nrow = ceiling(numPlots/cols))
#  }
#  
#  if (numPlots == 1) {
#    print(plots[[1]])
#    
#  } else {
#    # Set up the page
#    grid.newpage()
#    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
#    
#    # Make each plot, in the correct location
#    for (i in 1:numPlots) {
#      # Get the i,j matrix positions of the regions that contain this subplot
#      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
#      
#      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
#                                      layout.pos.col = matchidx$col))
#    }
#  }
#}

## DEPRECATED: Use ggarrange from ggpubr instear

## Function to create a shared legend for a figure without displacing or
## infringing on the space of other figures when using grid_arrange()
#grid_arrange_shared_legend <- function(..., ncol = length(list(...)), nrow = 1, position = c("bottom", "right")) {
#  
#  plots <- list(...)
#  position <- match.arg(position)
#  g <- ggplotGrob(plots[[1]] + theme(legend.position = position))$grobs
#  legend <- g[[which(sapply(g, function(x) x$name) == "guide-box")]]
#  lheight <- sum(legend$height)
#  lwidth <- sum(legend$width)
#  gl <- lapply(plots, function(x) x + theme(legend.position="none"))
#  gl <- c(gl, ncol = ncol, nrow = nrow)
#  
#  combined <- switch(position,
#                     "bottom" = arrangeGrob(do.call(arrangeGrob, gl),
#                                            legend,
#                                            ncol = 1,
#                                            heights = unit.c(unit(1, "npc") - lheight, lheight)),
#                     "right" = arrangeGrob(do.call(arrangeGrob, gl),
#                                           legend,
#                                           ncol = 2,
#                                           widths = unit.c(unit(1, "npc") - lwidth, lwidth)))
#  
#  grid.newpage()
#  grid.draw(combined)
#  
#  # return gtable invisibly
#  invisible(combined)
#  
#}

#--------------------------------------------------------------------------
#                                 Themes                                  #
#-------------------------------------------------------------------------#

# Themes deprecated; using ggpubr instead
