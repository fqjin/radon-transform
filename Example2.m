%%% Example 2: Find both peak and trough: particle velocity data
clc; clear; close all;

% Load Data
[xMm, tMsec, displ] = MakeSimData(2);
data = MakeDataStruct(xMm, tMsec, displ);

% Apply Radon Transform
theta = CalcTheta(data.dxdt);
radout = NormRadon(data.data, theta);

% Find Peak
peak = FindRadonPeaks(radout);
trough = FindRadonPeaks(radout, true);

% Calculate Trajectory
p_out = CalcTrajectory(peak, data);
t_out = CalcTrajectory(trough, data);
p_res = CalcResolution(radout, peak, data.dxdt, p_out.speed);
t_res = CalcResolution(radout, trough, data.dxdt, t_out.speed);
fprintf('Peak Speed: %.2f m/s\n', p_out.speed)
fprintf('--Resolution_th: %.2f m/s\n', p_res.res_th)
fprintf('--Resolution_rp: %.2f m/s\n', p_res.res_rp)
fprintf('Trough Speed: %.2f m/s\n', t_out.speed)
fprintf('--Resolution_th: %.2f m/s\n', t_res.res_th)
fprintf('--Resolution_rp: %.2f m/s\n', t_res.res_rp)

% Plot
PlotRadon(1, data, radout, peak, p_out, trough, t_out, false)
