%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finds peak(s) of radon transform
% Version 1.0, Felix Jin 2020, felix.jin@duke.edu
%
% Arguments:
%   radout (struct): struct containing {txfm, theta, rp}
%   trough_mode (bool): optional flag for finding trough
%
% Returns:
%   peak.max_val (scalar)
%   peak.th_ind (scalar)
%   peak.rp_ind (scalar)
%   peak.angle (scalar)
%   peak.rad_pos (scalar)
%   peak.trough_mode (bool)
%   peak.hittingedgeflag (bool): if angle is at edge of theta range
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: consider removing trough_mode
function peak = FindRadonPeaks(radout, trough_mode)
if ~exist('trough_mode', 'var')
    trough_mode = 0;
end
if nargin < 3
    if trough_mode
        radout.txfm = -1 * radout.txfm;
    end
    [max_val, max_ind] = max(radout.txfm(:));
    [rp_ind, th_ind] = ind2sub(size(radout.txfm), max_ind);
    angle = radout.theta(th_ind);
    rad_pos = radout.rp(rp_ind);

    peak.max_val = max_val;
    peak.th_ind = th_ind;
    peak.rp_ind = rp_ind;
    peak.angle = angle;
    peak.rad_pos = rad_pos;
    peak.trough_mode = trough_mode;
    if th_ind==1 || th_ind==length(radout.theta) || rp_ind==1 || rp_ind==length(radout.rp)
        peak.hittingedgeflag = 1;
    else
        peak.hittingedgeflag = 0;
    end
else
    error('NotImplementedError')
end
