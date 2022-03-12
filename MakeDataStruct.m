%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make Data Struct for processing
% Version 1.0, Felix Jin 2020, felix.jin@duke.edu
%
% Key values that are calculated are dx, dt, dxdt, and center.
% Note: cannot check linearity of xMm and tMsec due
%   to floating point error.
%
% Arguments:
%   xMm (vector)
%   tMsec (vector)
%   data_mat (matrix)

% Returns:
%   data.xMm (vector)
%   data.tMsec (vector)
%   data.dx (scalar)
%   data.dt (scalar)
%   data.dxdt (scalar)
%   data.center (2-tuple): [x,t] values of radon txfm center
%   data.data (matrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function data = MakeDataStruct(xMm, tMsec, data_mat)
if length(xMm) ~= size(data_mat, 1)
    error('xMm dimension does not match data')
end
if length(tMsec) ~= size(data_mat, 2)
    error('tMsec dimension does not match data')
end

x_center = xMm(floor((end+1)/2));
t_center = tMsec(floor((end+1)/2));
center = [x_center, t_center];

data.xMm = xMm;
data.tMsec = tMsec;
data.dx = xMm(2) - xMm(1);
data.dt = tMsec(2) - tMsec(1);
data.dxdt = data.dx / data.dt;
data.center = center;
data.data = data_mat;
end
