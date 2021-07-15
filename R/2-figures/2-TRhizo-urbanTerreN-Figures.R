#=========================================================================#
#                          TRhizo-urbanTerreN Figures                     #
#=========================================================================#

# Author: David Murray-Stoker (dstoker92@gmail.com)
# Last Updated: 14 July 2021

## Table of Contents
# Line  20: Load Packages & Data
# Line  44: Nodule Density Plots
# Line 139: Plant delta15N GAM Plots 
# Line 224: Correlation Plot
# Line 247: Soil N GAM Plots 
# Line 401: ESA Presentation Figures
# Line 471: End of Script


#=========================================================================#
#                            Load Packages & Data                         #
#==========================================================================
## Load the tidyverse
library(tidyverse)

## Packages for figure creation
library(calecopal)
library(corrplot)
library(ggpubr)
library(grid)
library(gridExtra)

## Read in workspace
load("R/1-analysis/1-analysis-workspace.RData")

## Set colour palette (caleco)
caleco.continuous <- cal_palette(name = "collinsia", n = 10, type = "continuous")


#=========================================================================#
#                                Figures                                  #
#==========================================================================

#-------------------------------------------------------------------------#
#                          Nodule Density Plots                           #
#--------------------------------------------------------------------------

## Nodule density by distance
nod.dens.distance.plot <- ggscatter(
	data = final.data,
	x = "distance.2.UC",
	y = "nod.density",
	color = "#A292C8",
	xlab = "Distance (km)",
	ylab = "Nodule Density (no./cm)",
	title = "(a)",
	ggtheme = theme_pubr()
) +
	geom_smooth(
		method = "lm", formula = y ~ x, se = TRUE, 
		colour = "#A5BA92", fill = "#A5BA92"
	) +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(0, 0.5, 1.0, 1.5), limits = c(0, 1.65)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20")

## Nodule density by percent ISC
nod.dens.ISC.plot <- ggscatter(
	data = final.data,
	x = "pct.ISC",
	y = "nod.density",
	color = "#A292C8",
	xlab = "ISC (%)",
	ylab = "Nodule Density (no./cm)",
	title = "(b)",
	ggtheme = theme_pubr()
) +
	geom_smooth(
		method = "lm", formula = y ~ x, se = TRUE, 
		colour = "#A5BA92", fill = "#A5BA92"
	) +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(0, 0.5, 1.0, 1.5), limits = c(0, 1.65)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20") +
	rremove("ylab") +
	rremove("y.text")

## Nodule density by NDVI
nod.dens.NDVI.plot <- ggscatter(
	data = final.data,
	x = "NDVI",
	y = "nod.density",
	color = "#A292C8",
	xlab = "NDVI",
	ylab = "Nodule Density (no./cm)",
	title = "(c)",
	ggtheme = theme_pubr()
) +
	geom_smooth(
		method = "lm", formula = y ~ x, se = TRUE, 
		colour = "#A5BA92", fill = "#A5BA92"
	) +
	scale_y_continuous(breaks = c(0, 0.5, 1.0, 1.5), limits = c(0, 1.65)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20") +
	ggtitle(label = "(c)") +
	rremove("ylab") +
	rremove("y.text")


## Arrange the figure
nod.density.figure <- ggarrange(
	nod.dens.distance.plot, nod.dens.ISC.plot, nod.dens.NDVI.plot,
	nrow = 1, ncol = 3,
	legend = "none", 
	common.legend = FALSE,
	widths = c(1.2, 1, 1)
	)


## Export the figure
ggsave(
	"fig_3-nod_density.pdf", 
	plot = nod.density.figure,
	device = "pdf",
	path = "figures/",
	width = 6,
	height = 3,
	units = "in",
	dpi = 900
	)


#-------------------------------------------------------------------------#
#                         Plant delta15N GAM Plots                        #
#--------------------------------------------------------------------------

## Delta15N and distance from the urban center
delta15N.distance.gam.plot <- ggscatter(
	data = final.data,
	x = "distance.2.UC",
	y = "delta15N",
	color = "#A292C8",
	xlab = "Distance (km)",
	ylab = expression(White~Clover~delta^{15}*"N"),
	title = "(a)",
	ggtheme = theme_pubr()
) +
	geom_smooth(
		method = "gam", formula = y ~ s(x), 
		colour = "#A5BA92", fill = "#A5BA92"
	) +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(-2.5, 0, 2.5, 5), limits = c(-2.75, 5.5)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20")

## Delta15N and percent ISC
delta15N.ISC.gam.plot <- ggscatter(
	data = final.data,
	x = "pct.ISC",
	y = "delta15N",
	color = "#A292C8",
	xlab = "ISC (%)",
	ylab = expression(White~Clover~delta^{15}*"N"),
	title = "(b)",
	ggtheme = theme_pubr()
) +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(-2.5, 0, 2.5, 5), limits = c(-2.75, 5.5)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20") +
	rremove("ylab") +
	rremove("y.text")

## Delta15N and NDVI
delta15N.NDVI.gam.plot <- ggscatter(
	data = final.data,
	x = "NDVI",
	y = "delta15N",
	color = "#A292C8",
	xlab = "NDVI",
	ylab = expression(White~Clover~delta^{15}*"N"),
	title = "(c)",
	ggtheme = theme_pubr()
) +
	scale_y_continuous(breaks = c(-2.5, 0, 2.5, 5), limits = c(-2.75, 5.5)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20") +
	rremove("ylab") +
	rremove("y.text")


## Arrange the figure
delta15N.figure <- ggarrange(
	delta15N.distance.gam.plot, delta15N.ISC.gam.plot, delta15N.NDVI.gam.plot,
	nrow = 1, ncol = 3,
	legend = "none", common.legend = FALSE,
	widths = c(1.2, 1, 1)
)


## Export the figure
ggsave(
	"fig_4-delta15N.pdf",
	plot = delta15N.figure,
	device = "pdf",
	path = "figures/",
	width = 6,
	height = 3,
	units = "in",
	dpi = 900
	)


#-------------------------------------------------------------------------#
#                              Correlation Plot                           #
#--------------------------------------------------------------------------

## Rename variables for plotting
colnames(correlation.matrix) <- c("Distance", "ISC", "NDVI", "Bulk Soil N", "Adjacent Soil N", "Clover delta 15N", "Nodule Density", "Total Nodules")
rownames(correlation.matrix) <- c("Distance", "ISC", "NDVI", "Bulk Soil N", "Adjacent Soil N", "Clover delta 15N", "Nodule Density", "Total Nodules")


## Correlation matrix between variables
corrplot(
	correlation.matrix,
	method = "ellipse", 
	type = "upper",
	col = colorRampPalette(caleco.continuous)(10), 
	tl.col = "gray0", 
	addCoef.col = TRUE, 
	tl.cex = 1.0, 
	cl.cex = 1.0, 
	number.cex = 1.5
	)


#-------------------------------------------------------------------------#
#                              Soil N GAM Plots                           #
#--------------------------------------------------------------------------

## Bulk soil N and distance
bulk.soil.N.distance.gam.plot <- ggscatter(
	data = final.data,
	x = "distance.2.UC",
	y = "bulk.pct.N",
	color = "#A292C8",
	xlab = "Distance (km)",
	ylab = "Bulk Soil N (%)",
	title = "(a)",
	ggtheme = theme_pubr()
) +
	geom_smooth(
		method = "gam", formula = y ~ s(x), 
		colour = "#A5BA92", fill = "#A5BA92"
	) +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(0, 0.3, 0.6), limits = c(0, 0.65)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20") +
	rremove("xlab") +
	rremove("x.text")

## Bulk soil N and ISC
bulk.soil.N.ISC.gam.plot <- ggscatter(
	data = final.data,
	x = "pct.ISC",
	y = "bulk.pct.N",
	color = "#A292C8",
	xlab = "ISC (%)",
	ylab = "Bulk Soil N (%)",
	title = "(b)",
	ggtheme = theme_pubr()
) +
	geom_smooth(
		method = "gam", formula = y ~ s(x), 
		colour = "#A5BA92", fill = "#A5BA92"
	) +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(0, 0.3, 0.6), limits = c(0, 0.65)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20") +
	rremove("ylab") +
	rremove("y.text") +
	rremove("xlab") +
	rremove("x.text")

## Bulk soil N and NDVI
bulk.soil.N.NDVI.gam.plot <- ggscatter(
	data = final.data,
	x = "NDVI",
	y = "bulk.pct.N",
	color = "#A292C8",
	xlab = "NDVI",
	ylab = "Bulk Soil N (%)",
	title = "(c)",
	ggtheme = theme_pubr()
) +
	scale_y_continuous(breaks = c(0, 0.3, 0.6), limits = c(0, 0.65)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20") +
	rremove("ylab") +
	rremove("y.text") +
	rremove("xlab") +
	rremove("x.text")

## Adjacent soil N and distance
adj.soil.N.distance.gam.plot <- ggscatter(
	data = final.data,
	x = "distance.2.UC",
	y = "adj.pct.N",
	color = "#A292C8",
	xlab = "Distance (km)",
	ylab = "Adjacent Soil N (%)",
	title = "(d)",
	ggtheme = theme_pubr()
) +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5), limits = c(0, 0.55)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20")

## Adjacent soil N and ISC
adj.soil.N.ISC.gam.plot <- ggscatter(
	data = final.data,
	x = "pct.ISC",
	y = "adj.pct.N",
	color = "#A292C8",
	xlab = "ISC (%)",
	ylab = "Adjacent Soil N (%)",
	title = "(e)",
	ggtheme = theme_pubr()
) +
	geom_smooth(
		method = "gam", formula = y ~ s(x), 
		colour = "#A5BA92", fill = "#A5BA92"
	) +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5), limits = c(0, 0.55)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20") +
	rremove("ylab") +
	rremove("y.text")

## Adjacent soil N and NDVI
adj.soil.N.NDVI.gam.plot <- ggscatter(
	data = final.data,
	x = "NDVI",
	y = "adj.pct.N",
	color = "#A292C8",
	xlab = "NDVI",
	ylab = "Adjacent Soil N (%)",
	title = "(f)",
	ggtheme = theme_pubr()
) +
	scale_y_continuous(breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5), limits = c(0, 0.55)) +
	font("xlab", size = 14, color = "gray0") +
	font("ylab", size = 14, color = "gray0") +
	font("xy.text", size = 10, color = "gray20") +
	rremove("ylab") +
	rremove("y.text")


## Arrange the figure
soil.N.figure <- ggarrange(
	bulk.soil.N.distance.gam.plot, bulk.soil.N.ISC.gam.plot, bulk.soil.N.NDVI.gam.plot,
	adj.soil.N.distance.gam.plot, adj.soil.N.ISC.gam.plot, adj.soil.N.NDVI.gam.plot,
	nrow = 2, ncol = 3,
	legend = "none", common.legend = FALSE,
	widths = c(1.2, 1, 1)
)


## Export the figure
ggsave(
	"fig_S2-soil_N.pdf",
	plot = soil.N.figure,
	device = "pdf",
	path = "figures/",
	width = 8,
	height = 6,
	units = "in",
	dpi = 900
	)


#-------------------------------------------------------------------------#
#                         ESA Presentation Figures                        #
#--------------------------------------------------------------------------

## Nodule density and distance from the urban center
nod.dens.distance.figure <- ggscatter(
	data = final.data,
	x = "distance.2.UC",
	y = "nod.density",
	color = "#A292C8",
	xlab = "Distance (km)",
	ylab = "Nodule Density (no./cm)",
	ggtheme = theme_pubr()
) +
	geom_smooth(
		method = "lm", formula = y ~ x, se = TRUE, 
		colour = "#A5BA92", fill = "#A5BA92"
	) +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(0, 0.5, 1.0, 1.5), limits = c(0, 1.65)) +
	font("xlab", size = 24, color = "gray0") +
	font("ylab", size = 24, color = "gray0") +
	font("xy.text", size = 18, color = "gray20")

## Export the figure
ggsave(
	"ESA_fig_1-nod_density.jpeg",
	plot = nod.dens.distance.figure,
	device = "jpeg",
	path = "figures/",
	width = 8,
	height = 6,
	units = "in",
	dpi = 1200
)


## Delta15N and distance from the urban center
delta15N.distance.gam.figure <- ggscatter(
	data = final.data,
	x = "distance.2.UC",
	y = "delta15N",
	color = "#A292C8",
	xlab = "Distance (km)",
	ylab = expression(White~Clover~delta^{15}*"N"),
	ggtheme = theme_pubr()
) +
	geom_smooth(
		method = "gam", formula = y ~ s(x), 
		colour = "#A5BA92", fill = "#A5BA92"
	) +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(-2.5, 0, 2.5, 5), limits = c(-2.75, 5.5)) +
	font("xlab", size = 24, color = "gray0") +
	font("ylab", size = 24, color = "gray0") +
	font("xy.text", size = 18, color = "gray20")

## Export the figure
ggsave(
	"ESA_fig_2-delta15N_distance.jpeg",
	plot = delta15N.distance.gam.figure,
	device = "jpeg",
	path = "figures/",
	width = 8,
	height = 6,
	units = "in",
	dpi = 1200
)


#=========================================================================#
#                             End of Script                               #
#=========================================================================#

