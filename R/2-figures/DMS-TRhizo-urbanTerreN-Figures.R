#=========================================================================#
#                             TRhizo-urbanTerreN                          #
#=========================================================================#

# Author: David Murray-Stoker (dstoker92@gmail.com)
# Last Updated: 30 October 2020

## Table of Contents
# Line  19: Load Packages & Data
# Line  44: Nodule Density Plots
# Line 110: Plant delta15N GAM Plots 
# Line 170: Correlation Plot
# Line 185: Soil N GAM Plots 
# Line 290: End of Script


#=========================================================================#
#                            Load Packages & Data                         #
#==========================================================================
library(corrplot)

## Load the tidyverse
library(tidyverse) 

## Read in workspace
load("~/Documents/Research/TRhizo-urbanTerreN/R/1-analysis/1-analysis-workspace.RData")

## Source code to load all packages for figure creation
source("R/2-figures/DMS-ggplot2-supplement.R")


## Set colour palette (caleco)
caleco.continuous <- cal_palette(name = "collinsia", n = 10, type = "continuous")
caleco.continuous


#=========================================================================#
#                                Figures                                  #
#==========================================================================


#-------------------------------------------------------------------------#
#                          Nodule Density Plots                           #
#--------------------------------------------------------------------------

## Nodule density by distance
nod.dens.distance.plot <- ggplot(data = final.data,
																 aes(x = distance.2.UC, y = nod.density)) + 
	geom_point(colour = "#A292C8") +
	geom_smooth(method = "lm", formula = y ~ x, se = TRUE, 
							colour = "#A5BA92", fill = "#A5BA92") +
	labs(x = "Distance (km)", y = "Nodule Density (no./cm)") +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(0, 0.5, 1.0, 1.5), limits = c(0, 1.65)) +
	theme_pubr() +
	theme(legend.position = "none") +
	ggtitle(label = "(a)")

## Nodule density by percent ISC
nod.dens.pct.ISC.plot <- ggplot(data = final.data,
																aes(x = pct.ISC, y = nod.density)) + 
	geom_point(colour = "#A292C8") +
	geom_smooth(method = "lm", formula = y ~ x, se = TRUE, 
							colour = "#A5BA92", fill = "#A5BA92") +
	labs(x = "ISC (%)", y = "Nodule Density (no./cm)") +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(0, 0.5, 1.0, 1.5), limits = c(0, 1.65)) +
	theme_pubr() +
	ggtitle(label = "(b)") +
	rremove("ylab") +
	rremove("y.text")

## Nodule density by NDVI
nod.dens.NDVI.plot <- ggplot(data = final.data,
														 aes(x = NDVI, y = nod.density)) + 
	geom_point(colour = "#A292C8") +
	geom_smooth(method = "lm", formula = y ~ x, se = TRUE, 
							colour = "#A5BA92", fill = "#A5BA92") +
	labs(x = "NDVI", y = "Nodule Density (no./cm)") +
	scale_y_continuous(breaks = c(0, 0.5, 1.0, 1.5), limits = c(0, 1.65)) +
	theme_pubr() +
	ggtitle(label = "(c)") +
	rremove("ylab") +
	rremove("y.text")


## Arrange the figure
nod.density.figure <- ggarrange(
	nod.dens.distance.plot, nod.dens.pct.ISC.plot, nod.dens.NDVI.plot,
	nrow = 1, ncol = 3,
	legend = "none", common.legend = FALSE,
	widths = c(1.2, 1, 1)
	)
nod.density.figure


## Export the figure
ggsave("fig_3-nod_density.pdf", 
			 plot = nod.density.figure,
			 device = "pdf",
			 path = "/Users/dms/Documents/Research/TRhizo-urbanTerreN/figures/",
			 width = 6,
			 height = 2.5,
			 units = "in",
			 dpi = 900)


#-------------------------------------------------------------------------#
#                         Plant delta15N GAM Plots                        #
#--------------------------------------------------------------------------

## Delta15N and distance from the urban center
delta15N.gam.plot.a <- ggplot(data = final.data,
															aes(x = distance.2.UC, y = delta15N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	geom_smooth(method = "gam", formula = y ~ s(x), na.rm = TRUE, 
							colour = "#A5BA92", fill = "#A5BA92") +
	labs(x = "Distance (km)", y = expression(White~Clover~delta^{15}*"N")) +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(-2.5, 0, 2.5, 5), limits = c(-2.75, 5.5)) +
	theme_pubr() +
	ggtitle(label = "(a)")

## Delta15N and percent ISC
delta15N.gam.plot.b <- ggplot(data = final.data,
															aes(x = pct.ISC, y = delta15N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	labs(x = "ISC (%)", y = expression(White~Clover~delta^{15}*"N")) +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(-2.5, 0, 2.5, 5), limits = c(-2.75, 5.5)) +
	theme_pubr() +
	ggtitle(label = "(b)") +
	rremove("ylab") +
	rremove("y.text")

## Delta15N and NDVI
delta15N.gam.plot.c <- ggplot(data = final.data,
															aes(x = NDVI, y = delta15N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	labs(x = "NDVI", y = expression(White~Clover~delta^{15}*"N")) +
	scale_y_continuous(breaks = c(-2.5, 0, 2.5, 5), limits = c(-2.75, 5.5)) +
	theme_pubr() +
	ggtitle(label = "(c)") +
	rremove("ylab") +
	rremove("y.text")

## Arrange the figure
delta15N.figure <- ggarrange(
	delta15N.gam.plot.a, delta15N.gam.plot.b, delta15N.gam.plot.c,
	nrow = 1, ncol = 3,
	legend = "none", common.legend = FALSE,
	widths = c(1.3, 1, 1)
)
delta15N.figure


## Export the figure
ggsave("fig_4-delta15N.pdf", 
			 plot = delta15N.figure,
			 device = "pdf",
			 path = "/Users/dms/Documents/Research/TRhizo-urbanTerreN/figures/",
			 width = 6,
			 height = 2.5,
			 units = "in",
			 dpi = 900)


#-------------------------------------------------------------------------#
#                              Correlation Plot                           #
#--------------------------------------------------------------------------

## Rename variables for plotting
colnames(correlation.matrix) <- c("Distance", "ISC", "NDVI", "Bulk Soil N", "Adjacent Soil N", "Nodule Density", "Total Nodules")
rownames(correlation.matrix) <- c("Distance", "ISC", "NDVI", "Bulk Soil N", "Adjacent Soil N", "Nodule Density", "Total Nodules")


## Correlation matrix between variables
corrplot(correlation.matrix, method = "ellipse", type = "upper",
				 col = colorRampPalette(caleco.continuous)(10), 
				 tl.col = "gray0", addCoef.col = TRUE, tl.cex = 1.0, cl.cex = 1.0, number.cex = 1.5)


#-------------------------------------------------------------------------#
#                              Soil N GAM Plots                           #
#--------------------------------------------------------------------------

## Bulk soil N and distance
soil.bulk.N.gam.plot.a <- ggplot(data = final.data,
																 aes(x = distance.2.UC, y = bulk.pct.N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	geom_smooth(method = "gam", formula = y ~ s(x), na.rm = TRUE, 
							colour = "#A5BA92", fill = "#A5BA92") +
	labs(x = "Distance (km)", y = "Bulk Soil N (%)") +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(0, 0.3, 0.6), limits = c(0, 0.6)) +
	theme_pubr() +
	ggtitle(label = "(a)") +
	rremove("xlab") +
	rremove("x.text")

## Bulk soil N and ISC
soil.bulk.N.gam.plot.b <- ggplot(data = final.data,
																 aes(x = pct.ISC, y = bulk.pct.N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	geom_smooth(method = "gam", formula = y ~ s(x), na.rm = TRUE, 
							colour = "#A5BA92", fill = "#A5BA92") +
	labs(x = "ISC (%)", y = "Bulk Soil N (%)") +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(0, 0.3, 0.6), limits = c(0, 0.6)) +
	theme_pubr() +
	ggtitle(label = "(b)") +
	rremove("ylab") +
	rremove("y.text") +
	rremove("xlab") +
	rremove("x.text")

## Bulk soil N and NDVI
soil.bulk.N.gam.plot.c <- ggplot(data = final.data,
																 aes(x = NDVI, y = bulk.pct.N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	labs(x = "NDVI", y = "Bulk Soil N (%)") +
	scale_y_continuous(breaks = c(0, 0.3, 0.6), limits = c(0, 0.6)) +
	theme_pubr() +
	ggtitle(label = "(c)") +
	rremove("ylab") +
	rremove("y.text") +
	rremove("xlab") +
	rremove("x.text")


## Adjacent soil N and distance
soil.adj.N.gam.plot.d <- ggplot(data = final.data,
																aes(x = distance.2.UC, y = adj.pct.N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	labs(x = "Distance (km)", y = "Adjacent Soil N (%)") +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5), limits = c(0, 0.525)) +
	theme_pubr() +
	ggtitle(label = "(d)")

## Adjacent soil N and ISC
soil.adj.N.gam.plot.e <- ggplot(data = final.data,
																aes(x = pct.ISC, y = adj.pct.N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	geom_smooth(method = "gam", formula = y ~ s(x), na.rm = TRUE, 
							colour = "#A5BA92", fill = "#A5BA92") +
	labs(x = "ISC (%)", y = "Adjacent Soil N (%)") +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5), limits = c(0, 0.525)) +
	theme_pubr() +
	ggtitle(label = "(e)") +
	rremove("ylab") +
	rremove("y.text")

## Adjacent soil N and NDVI
soil.adj.N.gam.plot.f <- ggplot(data = final.data,
																aes(x = NDVI, y = adj.pct.N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	labs(x = "NDVI", y = "Adjacent Soil N (%)") +
	scale_y_continuous(breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5), limits = c(0, 0.525)) +
	theme_pubr() +
	ggtitle(label = "(f)") +
	rremove("ylab") +
	rremove("y.text")


## Arrange the figure
soil.N.figure <- ggarrange(
	soil.bulk.N.gam.plot.a, soil.bulk.N.gam.plot.b, soil.bulk.N.gam.plot.c,
	soil.adj.N.gam.plot.d, soil.adj.N.gam.plot.e, soil.adj.N.gam.plot.f,
	nrow = 2, ncol = 3,
	legend = "none", common.legend = FALSE,
	widths = c(1.1, 1, 1)
)
soil.N.figure

## Export the figure
ggsave("fig_S2-soil_N.pdf", 
			 plot = soil.N.figure,
			 device = "pdf",
			 path = "/Users/dms/Documents/Research/TRhizo-urbanTerreN/figures/",
			 width = 8,
			 height = 6,
			 units = "in",
			 dpi = 900)


#=========================================================================#
#                             End of Script                               #
#=========================================================================#

