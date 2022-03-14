# Radon Transform
A Radon transform method for finding wave speeds from spatiotemporal data

## Overview
This package contains MATLAB scripts that use the Radon transform to estimate the wave speed from spatiotemporal particle motion data.
The code was developed for processing ultrasound shear wave elasticity (SWE) imaging data.

The Radon transform calculates the line integral of 2D data over all possible trajectories with a given angle or range of angles.
The slope of the trajectory that maximizes the Radon transform estimates the wavefront's group speed.

Features of this package:
* Adjustable range of speeds and resolution to search
* Uses a normalized Radon transform that accounts for trajectory length
* Can apply an arbitrary data mask that can by hand-drawn
* The inverse Radon transform can be used to mask out detected waves
* Visualize detected trajectories and Radon transform


## How to use
0. Load and pre-process your input spatiotemporal particle motion data.
1. Create a data struct using `MakeDataStruct`
2. Calculate trajectory angles with `CalcTheta`
3. Perform the normalized Radon transform with `NormRadon`
4. `FindRadonPeaks`
5. `CalcTrajectory`
6. (optional) `CalcResolution`
7. Use `PlotRadon` to visualize the results


## Examples



## Details
* `MakeSimData.m`: Generates simulated shear wave data
* `MakeDataStruct.m`: Creates data struct for external data
* `CalcTheta.m`: Creates list of theta angles
* `NormRadon.m`: Calculates normalized radon transform
* `FindRadonPeaks.m`: Finds peak(s) of radon transform
* `CalcTrajectory.m`: Calculates trajectory from radon coordinate
* `CalcResolution.m`: Calculates resolution of observed speed
* `PlotRadon.m`: Plots results


## License
Copyright 2022 Felix Q. Jin

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.