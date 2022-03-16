%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate theta angles for radon transform
%
% Creates a logspace / geomspace of wave speeds to
% search, unless a specific speed_list is provided.
%
% Arguments:
%   dxdt (scalar): Data spatiotemporal sampling ratio
%   n_speeds (scalar): Increasing n_speeds decreases the
%     spacing between speeds and increases the resolution.
%     Defaults to 128
%   speed_range (2-tuple): Range of allowed speeds.
%     Defaults to [0.5, 10.0]
%   speed_list (vector): Optional override to force only
%     specific speeds for theta.
%
% Returns:
%   theta (vector)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function theta = CalcTheta(dxdt, n_speeds, speed_range, speed_list)
if ~exist('speed_list', 'var')
    if ~exist('n_speeds', 'var')
        n_speeds = 128;
    end
    if ~exist('speed_range', 'var')
        speed_range = [0.5, 10.0];
    end
    speed_range = log10(speed_range);
    speed_list = logspace(speed_range(1), speed_range(2), n_speeds);
end
theta = acotd(sort(speed_list, 'descend') ./ dxdt);
