%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform normalized Radon transform
%
% To account for varying lengths of trajectories, the Radon
% transform of the data is divided by the Radon transform of
% a ones matrix. When an optional mask is used over the data,
% the ones matrix is also masked.
%
% radon_ones can be pre-calculated and provided to avoid repeat
% calculation when processing multiple data with the same mask.
%
% Arguments:
%   data (matrix)
%   theta (vector)
%   radon_ones (matrix): will be calculated if not provided
%   mask (matrix): multiplies data by mask and calculates radon_ones
%   epsilon (scalar): Threshold below which radon_ones will be set
%     to NaN, which suppresses short length trajectories. Default
%     is 0.1, meaning trajectories < 10% of max length are ignored.
%
% Returns:
%   radout.txfm (matrix): the normalized Radon transform
%   radout.theta (vector)
%   radout.rp (vector)
%   radout.radon_ones (matrix): the normalizing constant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function radout = NormRadon(data, theta, radon_ones, mask, epsilon)
if ~exist('epsilon', 'var')
    epsilon = 0.1;
end
if exist('mask', 'var') && ~isempty(mask)
    data = data .* mask;
    radon_ones = radon(mask, theta);
    radon_ones = radon_ones ./ max(radon_ones(:));
    radon_ones(radon_ones < epsilon) = NaN;
elseif ~exist('radon_ones', 'var') || isempty(radon_ones)
    radon_ones = radon(ones(size(data)), theta);
    radon_ones = radon_ones ./ max(radon_ones(:));
    radon_ones(radon_ones < epsilon) = NaN;
end

[txfm, rp] = radon(data, theta);
txfm = txfm ./ radon_ones;

radout.txfm = txfm;
radout.theta = theta;
radout.rp = rp;
radout.radon_ones = radon_ones;
