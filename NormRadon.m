%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalized radon transform
% Version 1.1, Felix Jin 2021, felix.jin@duke.edu
%
% Radon transform of data is divided by the radon
% transform of a ones matrix or input data mask.
%
% Arguments:
%   data (matrix)
%   theta (vector)
%   radon_ones(matrix): will be calculated if not provided
%   mask (matrix): multiplies data by mask and calculates radon_ones
%   epsilon (scalar): Threshold below which radon_ones will be set NaN
%       This suppresses short length trajectories.
%
% Returns:
%   radout.txfm (matrix)
%   radout.theta (vector)
%   radout.rp (vector)
%   radout.radon_ones (matrix)
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
