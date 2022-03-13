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
%   Mimicks skeletal muscle SWEI velocity data
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
    impulse = exp(-(tMsec_ext-xMm.'/speed).^2 / (2*sigma^2));
    data = zeros(length(xMm), length(tMsec));
    for i = 1:length(xMm)
        data(i,:) = conv(impulse(i,:), irf, 'valid');
    end
    data = data ./ (xMm.^decay).';
    data = data ./ max(data(:));
case 1
    xMm = linspace(2.12, 8.46, 16);
    tMsec = linspace(0.07, 17.89, 100);
    t_ = tMsec - 1.0;
    x_ = xMm.' / 2.0;
    data = cos(t_-x_) .* exp(-0.2 * (t_-x_ + 0.2 + 0.25*x_).^2);
    data = data .* (xMm .* exp(-0.5*xMm)).';
    noise = real(ifft2(abs(fft2(data)).^0.6 .* fft2(randn(size(data)))));
    data = data + 0.02 * noise;
case 2
    xMm = linspace(5.10, 9.98, 34);
    tMsec = linspace(0.86, 7.00, 310);
    t_ = tMsec - 0.7;
    x_ = xMm.' / 5.0;
    data = 0.1 * (2.75-x_) .* cos(2*(t_-x_)) .* exp(-.1*(t_-x_-0.5).^4);
    data = data + 0.15 - 0.05*tMsec;
    noise = imresize(randn(34, 7), [34, 310], 'bicubic');
    data = data + 0.03 * noise;
case 3
    xMm = 4:0.2:18;
    tMsec = 0.66:0.1:24.96;
    t_ = tMsec + 1.0;
    x_ = xMm.' / 2.0;
    decay = (1 ./ xMm.^2).';
    front = (tanh(t_-x_-1)+1);
    env = exp(-1./(x_.^0.7-1).*abs(t_-x_));
    osc = sin(200./(x_.^0.7).*(abs(t_-x_+4).^0.06 - 4.^0.06));
    sh = decay .* front .* env .* osc;
    
    t_ = tMsec + 1.2;
    x_ = xMm.' / 4.0;
    decay = 1 ./ xMm.';
    front = (tanh(t_-x_-1)+1);
    env = exp(-1./(x_.^0.7).*abs(t_-x_-1));
    osc = sin(200./(x_.^0.7).*(abs(t_-x_+4).^0.06 - 4.^0.06));
    sv = decay .* front .* env .* osc;
    
    t_ = tMsec;
    x_ = xMm.' / 3.0;
    data = cos(t_-x_) .* exp(-0.2 * (t_-x_ + 0.2 + 0.25*x_).^2);
    data = data .* (xMm .* exp(-0.5*xMm)).';
    data = sh + 0.03*sv + 0.02*data;
    data = data ./ max(data(:));
    noise = imresize(randn(71, 12), [71, 244], 'bicubic');
    data = data + 0.1 .* noise .* (1./(tMsec+2).^0.7);
end
