%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A mask that excludes data faster or slower than a given speed
%
% Waves are assumed to propagate from an origin, which defaults to (0,0)
% Adjustingc the wave's origin allows for fine tuning the mask.
%
% Arguments:
%   data (struct)
%   speed (scalar)
%   mode (string): mask out data 'faster' or 'slower' than speed
%   origin (2-tuple): [x,t] origin of wave at the boundary
%     Defaults to [0,0]
%
% Returns:
%   mask (matrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mask = MaskSpeed(data, speed, mode, origin)
if ~exist('origin','var')
    origin = [0,0];
end
[TT, XX] = meshgrid(data.tMsec - origin(2), data.xMm - origin(1));
mask = (XX >= 0) & (TT >= 0);
switch mode
case 'faster'
    mask = mask & (XX./TT <= speed);
case 'slower'
    mask = mask & (XX./TT >= speed);
end
