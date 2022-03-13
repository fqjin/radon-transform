%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make Simulated Shear Wave Data
%
% Mode 0:
%   Clean wave propagation (original version)
% Mode 1:
%   Mimicks in vivo SWEI displacement data
% Mode 2:
%   Mimicks ex vivo SWEI velocity data
% Mode 3:
%   Mimicks in vivo skeletal muscle SWEI
%   with two excited shear wave modes (SH & SV)
% 
% Arguments:
%   mode (int)
%
% Returns:
%   xMm (vector)
%   tMsec (vector)
%   data (matrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xMm, tMsec, data] = MakeSimData(mode)
if ~exist('mode', 'var')
mode = 0;
end

switch mode
case 0
    xMm = 2.4:0.2:7.0;
    tMsec = 0.62:0.12:12.5;
    speed = 2.0;
    lambda = 2.0;
    sigma = 0.5;
    decay = 0.53;
    irf = exp(-lambda * (tMsec-min(tMsec(:))));
    tMsec_ext = (-2*length(tMsec)+2:0)*mean(diff(tMsec)) + tMsec(end);
    response = zeros(length(xMm), length(tMsec));
    for i = 1:length(xMm)
        impulse = exp(-(tMsec_ext-xMm(i)/speed).^2/(2*sigma^2));
        response(i,:) = conv(impulse, irf, 'valid');
    end
    response = response ./ (xMm.^decay)';
    response = response ./ max(response(:));
    data = response;
case 1
case 2
case 3
end
