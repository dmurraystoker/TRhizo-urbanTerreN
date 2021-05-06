# TRhizo-urbanTerreN

Data, metadata, and R code for “Ecological consequences of urbanization on a legume-rhizobia mutualism”
================
David Murray-Stoker
23 January 2021

Data, metadata, and all R code for reproducing analyses for the manuscript:

Murray-Stoker, D., and M. T. J. Johnson. Ecological consequences of urbanization on a legume-rhizobia mutualism.

[![DOI](https://zenodo.org/badge/332053459.svg)](https://zenodo.org/badge/latestdoi/332053459)


## Abstract

Mutualisms are key determinants of community assembly and composition, but urbanization can alter the dynamics of these interactions and associated effects on ecosystem functions. Legume-rhizobia mutualisms are a model interaction to evaluate the ecological and ecosystem-level effects of urbanization, particularly urban-driven eutrophication and nitrogen (N) deposition. Here, we evaluated how urbanization affected the ecology of the mutualism between white clover *(Trifolium repens*) and its rhizobial symbiont (*Rhizobium leguminosarum* symbiovar *trifolii*) along an urbanization gradient. We found that the abundance of rhizobium nodules on white clover decreased with urbanization. White clover acquired N from mixed sources of N fixation and uptake from the soil for the majority of the urbanization gradient, but white clover primarily acquired N from the soil rather than N fixation by rhizobia at the urban and rural limits of the gradient. Importantly, we identified soil N as a critical nexus for urban-driven changes in the white clover-rhizobium mutualism. Taken together, our results demonstrate that urbanization alters the ecological consequences of a legume-rhizobium mutualism, with direct and indirect effects of the urban landscape on an ecologically-important mutualistic interaction.


## Contents

The [R Project](https://github.com/dmurraystoker/TRhizo-urbanTerreN/blob/main/TRhizo-urbanTerreN.Rproj) provides a local relative directory for all data and R code.


### Data

All data are provided in the [data folder](https://github.com/dmurraystoker/TRhizo-urbanTerreN/tree/main/data), with the associated metadata provided [here](https://github.com/dmurraystoker/TRhizo-urbanTerreN/blob/main/metadata.md). There are five data files associated with this project:

* TRhizo-site_information.csv (site information)
* TRhizo-nodule_counts.csv (nodule counts)
* TRhizo-landscape_data.csv (landscape data)
  - Landscape data were largely derived from land use and land cover calculations on Goggle Earth, with the kml file provided [here](https://github.com/dmurraystoker/TRhizo-urbanTerreN/blob/main/TRhizo-Urbanization%20Gradient.kml)
* TRhizo-soil_chemistry.csv (soil chemistry)
* TRhizo-clover_tissue_chemistry.csv (white clover leaf tissue chemistry)


### Figures

All figures used in the R Markdown report and manuscript are provided in the [figures folder](https://github.com/dmurraystoker/TRhizo-urbanTerreN/tree/main/figures). R Markdown uses the JEPG files while the higher resolution PDFs were used in the manuscript.


### R

R Markdown code and a script for figure creation are provided in the [R folder](https://github.com/dmurraystoker/TRhizo-urbanTerreN/tree/main/R). R Markdown code used for conducting all analyses and rendering the final report is provided in the [analysis folder](https://github.com/dmurraystoker/TRhizo-urbanTerreN/tree/main/R/1-analysis) while the R script for creating figures is in the [figures folder](https://github.com/dmurraystoker/TRhizo-urbanTerreN/tree/main/R/2-figures).

For the analyses, two separate workspaces are provided. The [analysis data workspace](https://github.com/dmurraystoker/TRhizo-urbanTerreN/blob/main/R/1-analysis/1-analysis-data.RData) contains all compiled and managed data through the downloading of NDVI. This is done as a time-saving measure as the download can take some time. The [final analysis workspace](https://github.com/dmurraystoker/TRhizo-urbanTerreN/blob/main/R/1-analysis/1-analysis-workspace.RData) provides all final data, models, and statistical results for transparency and reproducibility.


### Using this repository

To use the data and R code for this project:
1. `git clone` this repository or download it as a zip folder
2. Open `R Studio`, go to `file > Open project` and open the `TRhizo-urbanTerreN.Rproj`
R Project associated with this repository.
3. The analyses can be performed by running [1-analysis.Rmd](R/1-analysis/1-analysis.Rmd)

