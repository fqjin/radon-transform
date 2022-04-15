%%% Example 3: Hand-drawn mask
clc; clear; close all;

% Load Data
[xMm, tMsec, displ] = MakeSimData(3);
data = MakeDataStruct(xMm, tMsec, displ);

% Draw mask
mask = MaskManual(data, titletext='Draw a mask encircling one of the two waves');

% Apply Radon Transform
theta = CalcTheta(data.dxdt);
radout = NormRadon(data.data, theta, [], mask, 0.5);
    % a higher epsilon is needed since hand-drawn 
    % masks tend to wrap closely around the wave

% Find Peak
peak = FindRadonPeaks(radout);

% Calculate Trajectory
out = CalcTrajectory(data, peak);
res = CalcResolution(data, radout, peak);
fprintf('Calc Speed: %.2f m/s\n', out.speed)
fprintf('--Resolution_th: %.2f m/s\n', res.res_th)
fprintf('--Resolution_rp: %.2f m/s\n', res.res_rp)

% Plot
data.mask = mask;  % this makes it plot the mask overlay
PlotRadon(2, data, radout, peak, out)
