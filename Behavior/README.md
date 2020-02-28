# Playback and Discrimination Experiment

This subfolder contains the code and raw data for Picq et al. (2020) Figure 8 and Associated Analyses.  

## Field Behavior (Panel 8a)
Original code and analysis by Bruce Carlson

### Instructions for Running Experiment:
This protocol requires MATLAB as well as Tucker-Davis RM2 Mobile Processor, required ActiveX drivers and Data Acquisition Toolbox to be run.

1. Run `Field_Playback > stim1playback_novel_mobile.m` in MATLAB ensuring that `Laboratory_Playback` is on MATLAB path
2. EOD stimuli files are located under `Field Playback > EODs`.  

### Outputs
See: https://doi.org/10.5061/dryad.2z34tmphj

## Laboratory Behavior (Panel 8b)
Original Code and analysis performed by Josh Sperling and Carl Hopkins (Cornell University)

### Instructions for Running Experiment:
This protocol requires MATLAB as well as Tucker-Davis RM2 Mobile Processor, required ActiveX drivers and Data Acquisition Toolbox to be run.

1. Run `Laboratory_Playback > autodiscrim_interface.m` in MATLAB ensuring that `Laboratory_Playback > Code >Support_Code` is on MATLAB path
2. Load appropriate protocol in `Laboratory_Playback > Protocols` folder corresponding to appropriate experiment
3. EOD stimuli files are located in each protocol's folder under `EODs`.  Note that hybrid EODs were generated using code located in `Laboratory_Playback > Support_Code > autodiscrim_wavehybridizer.m`

_Note: File paths contained within protocol files are specific to the file system of the original computer that ran this analysis.  For simplicity and organization of this repository, files and folders have been reorganized, but filenames have not been altered.  As such, these protocol files may need to be edited to correspond to local file paths for complete reproducibility._

## Outputs:
1. See: https://doi.org/10.5061/dryad.2z34tmphj
2. Accessory scripts for viewing and analyzing data are located in `Acessory_Analysis_Scripts` directory
