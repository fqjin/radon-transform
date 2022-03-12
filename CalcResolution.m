%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate resolution for a radon peak
% Version 1.0, Felix Jin 2020, felix.jin@duke.edu
%
% Arguments:
%   radout (struct): containing {txfm, theta, rp}
%   peak (struct): containing {th_ind, rp_ind, trough_mode, hittingedgeflag}
%   dxdt (scalar)
%   speed (scalar)
%
% Returns:
%   res.res_th (scalar): speed resolution due to quantized theta
%   res.res_rp (scalar): speed resoultion due to quantized radial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function res = CalcResolution(radout, peak, dxdt, speed, suppress)
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

speeds_th = cotd(angles_th) * dxdt;
speeds_rp = cotd(angles_rp) * dxdt;
res_th = diff(speeds_th) / 2;
res_rp = diff(speeds_rp) / 2;
% res_th = max(abs(speeds_th - speed));
% res_rp = max(abs(speeds_rp - speed));

if res_th / speed > 0.1 && ~suppress
    warning('Resolution from theta >10%. Consider increasing n_angles.')
end
if res_rp / speed > 0.1 && ~suppress
    warning('Resolution from radial >10%. Consider upsampling in time.')
end
res.res_th = res_th;
res.res_rp = res_rp;
