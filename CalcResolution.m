%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate resolution for a radon peak
%
% This script is not necessary for wave speed estimation and can
% be skipped to save computational power. Two forms of resolution
% are computed: 1) from discretized speeds (theta) that are searched
% and 2) from discretized data.
%
% Arguments:
%   data (struct): containing {dxdt}
%   radout (struct): containing {txfm, theta, rp}
%   peak (struct): containing {th_ind, rp_ind, trough_mode, hittingedgeflag}
%
% Returns:
%   res.res_th (scalar): speed resolution due to quantized theta
%   res.res_rp (scalar): speed resoultion due to quantized radial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function res = CalcResolution(data, radout, peak, suppress)
if ~exist('suppress', 'var')
    suppress = false;
end
if peak.hittingedgeflag
    if ~suppress
        warning('NotImplementedError (hittingedgeflag)')
    end
    res.res_th = -1;
    res.res_rp = -1;
    return
end
if peak.trough_mode
    radout.txfm = -1 * radout.txfm;
end
angles_th = radout.theta(peak.th_ind + [1, -1]);
[~, angles_rp] = max(radout.txfm(peak.rp_ind + [1, -1], :), [], 2);
angles_rp = radout.theta(angles_rp);

speed = cotd(peak.angle) * data.dxdt;
speeds_th = cotd(angles_th) * data.dxdt;
speeds_rp = cotd(angles_rp) * data.dxdt;
res_th = diff(speeds_th) / 2;
res_rp = diff(speeds_rp) / 2;

if res_th / speed > 0.1 && ~suppress
    warning('Resolution from theta >10%. Consider increasing n_speeds.')
end
if res_rp / speed > 0.1 && ~suppress
    warning('Resolution from radial >10%. Consider upsampling data.')
end
res.res_th = res_th;
res.res_rp = res_rp;
