%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make a data struct containing input data
%
% Takes 2D spatiotemporal particle motion and coordinates.
% Automatically calculates dx, dt, dx/dt, and center point.
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
dx = mean(diff(xMm));
dt = mean(diff(tMsec));
if any(abs(diff(xMm)-dx)/dx > 1e-3)
    warning('xMm has non-uniform spacing')
end
if any(abs(diff(tMsec)-dt)/dt > 1e-3)
    warning('tMsec has non-uniform spacing')
end

x_center = xMm(floor((end+1)/2));
t_center = tMsec(floor((end+1)/2));
center = [x_center, t_center];

data.xMm = xMm;
data.tMsec = tMsec;
data.dx = dx;
data.dt = dt;
data.dxdt = dx / dt;
data.center = center;
data.data = data_mat;
end
