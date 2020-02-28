#EOD Analysis

This subfolder contains the code and raw data for Picq et al. (2020) analysis of electric organ discharges.  

This protocol requires MATLAB and R. EODs used in this analysis are available by request from the Cornell Museum of Vertebrates/Macaulay Library of Natural Sounds.  Specimen information is summarized in Table S1 of Supplemental Materials.

#I. Measuring EOD landmarks for PCA analysis (see Fig 3 and Table S2) in MATLAB
1. Run `EOD_Analysis > performeodanalysis.m` in MATLAB ensuring that `EOD_Analysis` is on MATLAB path
2. Output file contains 21 measurements for all EODs, located at https://doi.org/10.5061/dryad.2z34tmphj

#II. Performing cross-correlation analysis of EODs in MATLAB
1. Run `EOD_Analysis_Code > crosscorrelationEODs.m` in MATLAB. Select the folder containing EODs.
2. The program will output the MDS plot, coordinates of all individual EODs, as well as the population centroids. Output files are located at https://doi.org/10.5061/dryad.2z34tmphj and called `mds_eodcoordinates.csv` and `mds_centroids.csv`

## Downstream Analysis
1. Run  `PCA_signalanalysis_mantel.Rmd`. All input data files are located at https://doi.org/10.5061/dryad.2z34tmphj.
