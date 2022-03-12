%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make Simulated Shear Wave Data
% Version 1.0, Felix Jin 2020, felix.jin@duke.edu
% 
% Convolves a gaussian excitation with an overdamped
% oscillator (exponential decay), then applies 1/r^n
% scaling for each lateral location. Output is
% normalized by the maximum value.
% 
% Arguments:
%   xMm (vector)
%   tMsec (vector)
%   speed (scalar): wave speed in m/s
%   lambda (scalar): decay parameter of impulse response
%   sigma (scalar): std of gaussian impulse
%   decay (scalar): 1/r^n scaling power. Empirically ~0.53.

% Returns:
%   data.xMm (vector)
%   data.tMsec (vector)
%   data.dx (scalar)
%   data.dt (scalar)
%   data.dxdt (scalar)
%   data.speed (scalar)
%   data.center (2-tuple): [x,t] values of radon txfm center
%   data.data (matrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function data = MakeSimData(xMm, tMsec, speed, lambda, sigma, decay)
if ~exist('xMm', 'var')
    xMm = 2.4:0.2:7.0;
end
if ~exist('tMsec', 'var')
    tMsec = 0.62:0.12:12.5;
end
if ~exist('speed', 'var')
    speed = 2.0;
end
if ~exist('lambda', 'var')
    lambda = 2.0;
end
if ~exist('sigma', 'var')
    sigma = 0.5;
end
if ~exist('decay', 'var')
    decay = 0.53;
end

irf = exp(-lambda * (tMsec-min(tMsec(:))));
tMsec_ext = (-2*length(tMsec)+2:0)*mean(diff(tMsec)) + tMsec(end);
response = zeros(length(xMm), length(tMsec));
for i = 1:length(xMm)
    impulse = exp(-(tMsec_ext-xMm(i)/speed).^2/(2*sigma^2));
    response(i,:) = conv(impulse, irf, 'valid');
end
response = response ./ (xMm.^decay)';
response = response ./ max(response(:));
x_center = xMm(floor((end+1)/2));
t_center = tMsec(floor((end+1)/2));
center = [x_center, t_center];

data.xMm = xMm;
data.tMsec = tMsec;
data.dx = xMm(2) - xMm(1);
data.dt = tMsec(2) - tMsec(1);
data.dxdt = data.dx / data.dt;
data.speed = speed;
data.center = center;
data.data = response;
