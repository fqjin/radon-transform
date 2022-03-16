%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate trajectory from radon coordinates
%
% Arguments:
%   data (struct): containing {xMm, dx, dt, dxdt, center}
%   peak (struct): containing {angle, rad_pos}
%
% Returns:
%   out.speed (scalar)
%   out.times (vector): time for each xMm position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = CalcTrajectory(data, peak)
speed = cotd(peak.angle) * data.dxdt;
offset = peak.rad_pos * [-data.dx*sind(peak.angle), data.dt*cosd(peak.angle)];
center = data.center + offset;
times = center(2) + (data.xMm - center(1))./speed;

out.speed = speed;
out.times = times;
