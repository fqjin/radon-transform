%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate theta angles for radon transform
%
% Arguments:
%   dxdt (scalar): Data spatiotemporal sampling ratio
%   n_angles (scalar): Increasing n_angles decreases the
%     spacing between speeds and increases the resolution.
%     Defaults to 64
%   speed_range (2-tuple): Range of allowed speeds.
%     Defaults to [0.5, 10.0]
%   speed_list (vector): Optional override to force only
%     specific speeds for theta.
%
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
    speed_range = [0.5, 10.0];
end
maxmin_angle = acotd(speed_range ./ dxdt);
theta = linspace(maxmin_angle(2), maxmin_angle(1), n_angles);
