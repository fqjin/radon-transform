%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate theta range for radon transform
% Version 1.0, Felix Jin 2020, felix.jin@duke.edu
%
% Arguments:
%   dxdt (scalar): Slope of data matrix
%   n_angles (scalar): Defaults to 64
%   speed_range (2-tuple): Defaults to [0.3, 10.0]
%   speed_list (vector): Optional override using
%     the provided specific speeds for angles.

% Returns:
%   theta (vector)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function theta = CalcTheta(dxdt, n_angles, speed_range, speed_list)
if exist('speed_list', 'var')
    theta = acotd(sort(speed_list, 'descend') ./ dxdt);
    return
end
if ~exist('n_angles', 'var')
    n_angles = 64;
end
if ~exist('speed_range', 'var')
    speed_range = [0.3, 10.0];
end
maxmin_angle = acotd(speed_range ./ dxdt);
theta = linspace(maxmin_angle(2), maxmin_angle(1), n_angles);
