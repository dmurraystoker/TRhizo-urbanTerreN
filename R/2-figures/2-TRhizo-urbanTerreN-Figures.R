#=========================================================================#
#                          TRhizo-urbanTerreN Figures                     #
#=========================================================================#

# Author: David Murray-Stoker (dstoker92@gmail.com)
# Last Updated: 28 April 2021

## Table of Contents
# Line XXX: Load Packages & Data
# Line XXX: Nodule Density Plots
# Line XXX: Plant delta15N GAM Plots 
# Line XXX: Correlation Plot
# Line XXX: Soil N GAM Plots 
# Line XXX: End of Script


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
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*" = 0.146"), parse = TRUE, size = 4) +
	annotate("text", x = 45, y = 1.4, 
					 label = "P == 0.031", parse = TRUE, size = 4) +
	annotate("text", x = 45, y = 1.3, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 4) +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20")
nod.dens.distance.plot

## Nodule density by percent ISC
nod.dens.pct.ISC.plot <- ggplot(
	data = final.data,
	aes(x = pct.ISC, y = nod.density)
	) + 
	geom_point(colour = "#A292C8") +
	geom_smooth(
		method = "lm", formula = y ~ x, se = TRUE,
		colour = "#A5BA92", fill = "#A5BA92"
		) +
	labs(x = "ISC (%)", y = "Nodule Density (no./cm)") +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(0, 0.5, 1.0, 1.5), limits = c(0, 1.65)) +
	annotate("text", x = 80, y = 1.5, 
					 label = expression(beta*" = -0.199"), parse = TRUE, size = 1.5) +
	annotate("text", x = 80, y = 1.4, 
					 label = "P == 0.003", parse = TRUE, size = 1.5) +
	annotate("text", x = 80, y = 1.3, 
					 label = expression("R"["c"]^"2" == 0.151), parse = TRUE, size = 1.5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
	ggtitle(label = "(b)") +
	rremove("ylab") +
	rremove("y.text")

## Nodule density by NDVI
nod.dens.NDVI.plot <- ggplot(
	data = final.data,
	aes(x = NDVI, y = nod.density)
	) + 
	geom_point(colour = "#A292C8") +
	geom_smooth(
		method = "lm", formula = y ~ x, se = TRUE, 
		colour = "#A5BA92", fill = "#A5BA92"
		) +
	labs(x = "NDVI", y = "Nodule Density (no./cm)") +
	scale_y_continuous(breaks = c(0, 0.5, 1.0, 1.5), limits = c(0, 1.65)) +
	annotate("text", x = 7500, y = 1.5, 
					 label = expression(beta*" = 0.152"), parse = TRUE, size = 1.5) +
	annotate("text", x = 7500, y = 1.4, 
					 label = "P == 0.021", parse = TRUE, size = 1.5) +
	annotate("text", x = 7500, y = 1.3, 
					 label = expression("R"["c"]^"2" == 0.146), parse = TRUE, size = 1.5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
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
ggsave("fig_3-nod_density.jpeg", 
			 plot = nod.density.figure,
			 device = "jpeg",
			 path = "figures/",
			 width = 6,
			 height = 3,
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
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*"= 0.146"), parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.35, 
					 label = "P == 0.031", parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.20, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
	ggtitle(label = "(a)")

## Delta15N and percent ISC
delta15N.gam.plot.b <- ggplot(data = final.data,
															aes(x = pct.ISC, y = delta15N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	labs(x = "ISC (%)", y = expression(White~Clover~delta^{15}*"N")) +
	scale_x_continuous(breaks = c(0, 30, 60, 90), limits = c(0, 90.5)) +
	scale_y_continuous(breaks = c(-2.5, 0, 2.5, 5), limits = c(-2.75, 5.5)) +
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*"= 0.146"), parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.35, 
					 label = "P == 0.031", parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.20, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
	ggtitle(label = "(b)") +
	rremove("ylab") +
	rremove("y.text")

## Delta15N and NDVI
delta15N.gam.plot.c <- ggplot(data = final.data,
															aes(x = NDVI, y = delta15N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	labs(x = "NDVI", y = expression(White~Clover~delta^{15}*"N")) +
	scale_y_continuous(breaks = c(-2.5, 0, 2.5, 5), limits = c(-2.75, 5.5)) +
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*"= 0.146"), parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.35, 
					 label = "P == 0.031", parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.20, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
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
ggsave("fig_4-delta15N.jpeg", 
			 plot = delta15N.figure,
			 device = "jpeg",
			 path = "figures/",
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
soil.bulk.N.gam.plot.a <- ggplot(data = final.data,
																 aes(x = distance.2.UC, y = bulk.pct.N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	geom_smooth(method = "gam", formula = y ~ s(x), na.rm = TRUE, 
							colour = "#A5BA92", fill = "#A5BA92") +
	labs(x = "Distance (km)", y = "Bulk Soil N (%)") +
	scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50), limits = c(0, 50.5)) +
	scale_y_continuous(breaks = c(0, 0.3, 0.6), limits = c(0, 0.6)) +
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*"= 0.146"), parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.35, 
					 label = "P == 0.031", parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.20, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
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
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*"= 0.146"), parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.35, 
					 label = "P == 0.031", parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.20, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
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
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*"= 0.146"), parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.35, 
					 label = "P == 0.031", parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.20, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
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
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*"= 0.146"), parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.35, 
					 label = "P == 0.031", parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.20, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
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
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*"= 0.146"), parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.35, 
					 label = "P == 0.031", parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.20, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
	ggtitle(label = "(e)") +
	rremove("ylab") +
	rremove("y.text")

## Adjacent soil N and NDVI
soil.adj.N.gam.plot.f <- ggplot(data = final.data,
																aes(x = NDVI, y = adj.pct.N)) + 
	geom_point(na.rm = TRUE, colour = "#A292C8") +
	labs(x = "NDVI", y = "Adjacent Soil N (%)") +
	scale_y_continuous(breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5), limits = c(0, 0.525)) +
	annotate("text", x = 45, y = 1.5, 
					 label = expression(beta*"= 0.146"), parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.35, 
					 label = "P == 0.031", parse = TRUE, size = 5) +
	annotate("text", x = 45, y = 1.20, 
					 label = expression("R"["c"]^"2" == 0.147), parse = TRUE, size = 5) +
	theme_pubr() +
	font("xlab", size = 16, color = "gray0") +
	font("ylab", size = 16, color = "gray0") +
	font("xy.text", size = 14, color = "gray20") +
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
ggsave("fig_S2-soil_N.jpeg", 
			 plot = soil.N.figure,
			 device = "jpeg",
			 path = "figures/",
			 width = 8,
			 height = 6,
			 units = "in",
			 dpi = 900)


#=========================================================================#
#                             End of Script                               #
#=========================================================================#

