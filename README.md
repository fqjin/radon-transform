# Radon Transform
A Radon transform method for finding wave speeds from spatiotemporal data

## Overview
This package contains MATLAB scripts that use the Radon transform to estimate the wave speed from spatiotemporal particle motion data.
The code was developed for processing ultrasound shear wave elasticity (SWE) imaging data.


## Contents
* `MakeSimData.m`: Creates data using a damped-spring model
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