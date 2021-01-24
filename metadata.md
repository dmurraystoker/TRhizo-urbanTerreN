Metadata for “Ecological consequences of urbanization on a
legume-rhizobia mutualism”
================
David Murray-Stoker

# TRhizo-urbanTerreN

Metadata associated with the manuscript:

Murray-Stoker, D. and M. T. J. Johnson. Ecological consequences of
urbanization on a legume-rhizobia mutualism.

## Metadata

### Site information

file = TRhizo-site\_information.csv

| Variable   | Description                                                                              |
|:-----------|:-----------------------------------------------------------------------------------------|
| site.ID    | Site number and unique identifier                                                        |
| date       | Date the site was sampled                                                                |
| start.time | Time of day (EST) sample collection began at the site                                    |
| latitude   | Latitude of the site in decimal degrees                                                  |
| longitude  | Longitude of the site in decimal degrees                                                 |
| notes      | Descriptions of nearby landmarks or other identifiers transferred from my field notebook |

### Nodule data

file = TRhizo-nodule\_counts.csv

| Variable     | Description                                                                                                |
|:-------------|:-----------------------------------------------------------------------------------------------------------|
| city         | Toronto; artifact of potential multi-city sampling                                                         |
| site.ID      | Site number and unique identifier                                                                          |
| plant        | random number assigned to the collected white clover individual                                            |
| root.1.L     | length (cm) of the first measured root                                                                     |
| root.2.L     | length (cm) of the second measured root                                                                    |
| root.3.L     | length (cm) of the third measured root                                                                     |
| root.4.L     | length (cm) of the fourth measured root                                                                    |
| root.5.L     | length (cm) of the fifth measured root                                                                     |
| root.1.nod   | nodule count on the first measured root                                                                    |
| root.2.nod   | nodule count on the second measured root                                                                   |
| root.3.nod   | nodule count on the third measured root                                                                    |
| root.4.nod   | nodule count on the fourth measured root                                                                   |
| root.5.nod   | nodule count on the fifth measured root                                                                    |
| total.root.L | total root length measured (in cm) of the collected white clover individual                                |
| total.nod    | total nodule count (number) of the collected white clover individual                                       |
| nod.density  | total.nod / total.root.L; number of nodules per cm of root length of the collected white clover individual |

### Landscape data

file = TRhizo-landscape\_data.csv

| Variable      | Description                                                                                         |
|:--------------|:----------------------------------------------------------------------------------------------------|
| site.ID       | Site number and unique identifier                                                                   |
| circle.radius | length of the radius (in m) of the circle used for estimating land cover attributes in Google Earth |
| circle.area   | area of the circle (in m^2) for estimating land cover attributes in Google Earth                    |
| area.ISC      | area (in m^2) of impervious surface cover within the circle                                         |
| area.ag       | area (in m^2) of agricultural cover within the circle                                               |
| area.green    | area (in m^2) of non-impervious and non-agricultural cover within the circle                        |
| pct.ISC       | area.ISC/circle.area; percent impervious surface cover within the circle                            |
| pct.ag        | area.ag/circle.area; percent agricultural cover within the circle                                   |
| pct.green     | area.green/circle.area; percent green cover within the circle                                       |
| qual.LULC     | Qualitative designation of the site as urban, suburban, or rural                                    |
| cover.type    | Qualitative description of the immediate surrounding land cover at the site                         |

### Soil chemistry

file = TRhizo-soil\_chemistry.csv

| Variable   | Description                                                                     |
|:-----------|:--------------------------------------------------------------------------------|
| site.ID    | Site number and unique identifier                                               |
| adj.pct.N  | Percent nitrogen content in soil adjacent to collected white clover at the site |
| bulk.pct.N | Percent nitrogen content in bulk soil at the site                               |

### White clover chemistry

file = TRhizo-clover\_tissue\_chemistry.csv

| Variable  | Description                                                                             |
|:----------|:----------------------------------------------------------------------------------------|
| site.ID   | Site number and unique identifier                                                       |
| percent.N | Percent nitrogen content of the composite white clover leaf tissue sample for the site  |
| delta15N  | delta 15 N stable isotope of the composite white clover leaf tissue sample for the site |
