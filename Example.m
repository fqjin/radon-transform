%%% Example 1: Basic usage of the radon-transform package
clc; clear; close all;

% Load Data
[xMm, tMsec, displ] = MakeSimData(1);
data = MakeDataStruct(xMm, tMsec, displ);

% Apply Radon Transform
theta = CalcTheta(data.dxdt);
radout = NormRadon(data.data, theta);

% Find Peak
peak = FindRadonPeaks(radout);

% Calculate Trajectory
out = CalcTrajectory(peak, data);
res = CalcResolution(radout, peak, data.dxdt, out.speed);
fprintf('Calc Speed: %.2f m/s\n', out.speed)
fprintf('--Resolution_th: %.2f m/s\n', res.res_th)
fprintf('--Resolution_rp: %.2f m/s\n', res.res_rp)

% Plot
PlotRadon(1, data, radout, peak, out)
