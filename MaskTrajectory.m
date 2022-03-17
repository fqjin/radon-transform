%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a mask that excludes a detected trajectory
%
% The inverse Radon transofrm is used to convert a detected peak
% in a Radon transform into a mask based on that trajectory. The
% mask can only be used with data and radout with the same shape.
%
% Arguments:
%   data (struct)
%   radout (struct)
%   peak (struct)
%   threshold (scalar): threshold radout.txfm value above which
%     the trajectory is masked. Default is 50% of peak.max_val.
%
% Returns:
%   mask (matrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mask = MaskTrajectory(data, radout, peak, threshold)
if ~exist('threshold', 'var')
    threshold = 0.5 .* peak.max_val;
end
if peak.trough_mode
    radout.txfm = -1 * radout.txfm;
end
[xsize, tsize] = size(data.data);
if tsize <= xsize
    error('NotImplementedError: currently requires tsize > xsize')
end
x1 = floor(0.5 * (tsize - xsize));
x2 = x1 + xsize - 1;

slice = squeeze(radout.txfm(:,peak.th_ind));
slice(isnan(slice)) = 0;
r_min = find(slice(1:peak.rp_ind) < threshold, 1, 'last') + 1;
r_max = find(slice(peak.rp_ind:end) < threshold, 1) + peak.rp_ind - 2;

radon_mask = zeros(size(radout.txfm));
radon_mask(r_min:r_max, peak.th_ind) = 1;
mask = iradon(radon_mask, radout.theta, 'linear', 'Ram-Lak', 1, tsize) <= 0;
mask = mask(x1:x2,:);
