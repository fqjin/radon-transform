[![DOI](https://zenodo.org/badge/469215495.svg)](https://zenodo.org/badge/latestdoi/469215495)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Radon transform wave-speed estimator
This package contains MATLAB scripts that use the Radon transform to find the wave speed and trajectory from spatiotemporal particle motion data.
This code was developed for processing ultrasound shear wave elasticity imaging data (SWE/SWEI).

The Radon transform calculates the line integral of 2D data over all possible trajectories.
The slope of the trajectory that maximizes the Radon transform is the group speed of the wavefront.

Features of this package:
* Adjustable speed range and resolution
* Normalized Radon transform accounts for trajectory length and gives a strength metric equal to the average data along the trajectory
* Apply arbitrary masks to input data, with helper scripts to make various masks, including hand-drawn masks


## Examples
Refer to the example scripts to see how this package is used:

Example 1: Basic usage

<img src="./imgs/Example1.png" width="80%">

Example 2: Find speeds of peak and trough in particle velocity data

<img src="./imgs/Example2.png" width="80%">

Example 3: Hand-drawn masks

<img src="./imgs/Example3a.png" width="48%"><img src="./imgs/Example3b.png" width="48%">

Example 4: Detect multiple waves with trajectory masking

<img src="./imgs/Example4a.png" width="48%"><img src="./imgs/Example4b.png" width="48%">


## How to use
0. Load and pre-process your spatiotemporal particle motion data
1. Create a data struct with `MakeDataStruct`
2. Use `CalcTheta` to generate a speed search range 
3. Use `NormRadon` to perform the normalized Radon transform, with optional masking (see notes) 
4. Use `FindRadonPeaks` to find the transform's peak
5. Use `CalcTrajectory` to calculate the wave speed and trajectory.
   * (optional) `CalcResolution` estimates the resolution for the output speed
6. Visualize results with `PlotRadon`


## Notes
* `MakeDataStruct` requires three quantities: a 2D array of spatiotemporal data and the corresponding vectors for spatial and temporal coordinates.
* Common pre-processing steps (not required): filtering, resampling, differentiating in time, cropping, normalizing in time at each spatial location, etc.
* `CalcTheta` may be passed a specific list of discrete wave speeds to search.
By default, it constructs a logarithmically-spaced speed range.
* `NormRadon` may be passed a mask to apply it to the input data. This package contains the following helper scripts to generate useful masks:
  * `MaskManual`: the user manually circles the desired wave and the drawing is used as a mask. This is particularly useful for data with multiple waves or to avoid artifacts.
  * `MaskTrajectory` uses the inverse Radon transform to mask out a specified trajectory
  * `MaskSpeed` creates a speed-based mask to isolate data faster or slower than a specified speed


## Reference
If you use this package, please cite the Zenodo DOI.

If you use this package for ultrasound SWE/SWEI, please also cite the paper that first proposed this approach:

[N. C. Rouze, M. H. Wang, M. L. Palmeri and K. R. Nightingale, "Robust estimation of time-of-flight shear wave speed using a radon sum transformation," in IEEE Transactions on Ultrasonics, Ferroelectrics, and Frequency Control, vol. 57, no. 12, pp. 2662-2670, December 2010.](https://doi.org/10.1109/TUFFC.2010.1740)
