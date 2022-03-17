%%% Example 4: Detect multiple waves using masking
clc; clear; close all;

% Load Data
[xMm, tMsec, displ] = MakeSimData(3);
data = MakeDataStruct(xMm, tMsec, displ);
theta = CalcTheta(data.dxdt);

% Find first wave without masking
radout1 = NormRadon(data.data, theta);
peak1 = FindRadonPeaks(radout1);
out1 = CalcTrajectory(data, peak1);
res1 = CalcResolution(data, radout1, peak1);
fprintf('Calc Speed: %.2f m/s\n', out1.speed)
fprintf('--Resolution_th: %.2f m/s\n', res1.res_th)
fprintf('--Resolution_rp: %.2f m/s\n', res1.res_rp)

% Create trajectory based mask
mask = MaskTrajectory(data, radout1, peak1);

% Find second wave by masking out the first 
radout2 = NormRadon(data.data, theta, [], mask, 0.2);
peak2 = FindRadonPeaks(radout2);
out2 = CalcTrajectory(data, peak2);
res2 = CalcResolution(data, radout2, peak2);
fprintf('Calc Speed: %.2f m/s\n', out2.speed)
fprintf('--Resolution_th: %.2f m/s\n', res2.res_th)
fprintf('--Resolution_rp: %.2f m/s\n', res2.res_rp)

% Plot
PlotRadon(1, data, radout1, peak1, out1, [], [], false)
data.mask = mask;  % this makes it plot the mask overlay
PlotRadon(2, data, radout2, peak2, out2, [], [], false)
