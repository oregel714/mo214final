# Recreating a figure of ion concentrations in streams before and after Hurricane Hugo. 

## Purpose 
The purpose of this repository is to house the code for recreating the figure, while also running the analysis of the data that the figure displays. This includes a moving average for each site in addition to any other analyses performed. 

![](Images/Schaefer_etal_2020_fig3.png)

**Figure 3:** Concentrations in Bisley, Puerto Rico streams before and after Hurricane Hugo, 9-wk moving averages. (a) potassium, (b) nitrate-N, (c) magnesium, (d) calcium, and (e) ammonium-N. The vertical lines mark the time of hurricane disturbance. Reproduced from Schaefer et al. (2000). 

## Repository Structure 
This repository currently contains nine folders: 

### data: 
The data folder contains the data frames that are displayed in the figure.

- QuebradaCuenca1-Bisley.csv
- QuebradaCuenca2-Bisley.csv
- QuebradaCuenca3-Bisley.csv
- RioMameyesPueneRoto.csv

### scratch:
The scratch folder contains the working code for creating an empty data frame which will be populated by the manipulated data contained in the data folder. 

## Data Access
All data used to recreate the figure was acquired from the Environmental Data Initiative and is housed in the data folder within this repository. 

## Collaborators
All code within this repository was written by MEDS student Mark Oregel. 

## References 
McDowell, William H., and USDA Forest Service. International Institute Of Tropical Forestry (IITF). 2024. “Chemistry of Stream Water from the Luquillo Mountains.” [Environmental Data Initiative](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-luq.20.4923064). https://doi.org/10.6073/PASTA/F31349BEBDC304F758718F4798D25458.

Schaefer, Douglas. A., William H. McDowell, Fredrick N. Scatena, and Clyde E. Asbury. 2000. “Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico.” Journal of Tropical Ecology 16 (2): 189–207. https://doi.org/10.1017/s0266467400001358.


