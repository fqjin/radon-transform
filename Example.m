%%% Example 1: Radon Transform Scripts
clc; clear; close all;
% Load Data
data = MakeSimData();
fprintf('True Speed: %.2f m/s\n', data.speed)

% Apply Radon Txfm
theta = CalcTheta(data.dxdt);
radout = NormRadon(data.data, theta);

% Find Peak
peak = FindRadonPeaks(radout);

% Calc Trajectory
out = CalcTrajectory(peak, data);
res = CalcResolution(radout, peak, data.dxdt, out.speed);
fprintf('Calc Speed: %.2f m/s\n', out.speed)
fprintf('--Resolution_th: %.2f m/s\n', res.res_th)
fprintf('--Resolution_rp: %.2f m/s\n', res.res_rp)

% Plot
PlotRadon(1, data, radout, peak, out)
