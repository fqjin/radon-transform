%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot data, radon transform, and trajectories
%
% Arguments:
%   fignum (int)
%   data (struct)
%   radout (struct)
%   peak (struct)
%   p_out (struct)
%   trough (struct): optional
%   t_out (struct): optional
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PlotRadon(fignum, data, radout, peak, p_out, trough, t_out)
if fignum > 0
    figure(fignum)
    clf
end
blue = [0, 0.4470, 0.7410];
oran = [0.8500, 0.3250, 0.0980];

tiledlayout(3, 5, 'TileSpacing', 'none')
nexttile(1, [2, 2])
imagesc(data.tMsec, data.xMm, data.data)
hold on
plot(p_out.times, data.xMm, 'k', 'LineWidth', 2)
if exist('t_out', 'var')
plot(t_out.times, data.xMm, 'w', 'LineWidth', 2)
end
xlabel('time (ms)');
ylabel('lateral (mm)');
colorbar
if ~exist('t_out', 'var')
title(sprintf('Speed = %.2f m/s', p_out.speed))
else
title(sprintf('Peak=%.2f m/s , Trough=%.2f m/s', p_out.speed, t_out.speed))
end

nexttile(3, [2, 2])
imagesc(radout.theta, radout.rp, radout.txfm)
hold on
plot(peak.angle, peak.rad_pos, '.k', 'MarkerSize', 12)
if exist('trough', 'var')
plot(trough.angle, trough.rad_pos, '.w', 'MarkerSize', 12)
end
title('Radon Transform')
set(gca, 'YAxisLocation', 'right')

nexttile(5, [2, 1])
max_line = max(radout.txfm, [], 2);
plot(max_line, radout.rp, 'Color',blue,'LineWidth',1)
hold on
if ~exist('trough', 'var')
plot([min(max_line), peak.max_val], [peak.rad_pos, peak.rad_pos], '--','Color',blue,'LineWidth',1)
else
plot([0, peak.max_val], [peak.rad_pos, peak.rad_pos], '--','Color',blue,'LineWidth',1)
plot([0, 0], radout.rp([1, end]), 'k')
plot(min(radout.txfm, [], 2), radout.rp, 'Color',oran,'LineWidth',1)
plot([-trough.max_val, 0], [trough.rad_pos, trough.rad_pos], '--','Color',oran,'LineWidth',1)
end
ylim(radout.rp([1,end]))
set(gca, 'YDir', 'reverse')
set(gca,'Yticklabel',[])
ylabel('radial position')

nexttile(13, [1, 2])
max_line = max(radout.txfm, [], 1);
plot(radout.theta, max_line, 'Color',blue,'LineWidth',1)
hold on
if ~exist('trough', 'var')
plot([peak.angle, peak.angle], [min(max_line), peak.max_val], '--','Color',blue,'LineWidth',1)
else
plot([peak.angle, peak.angle], [0, peak.max_val], '--','Color',blue,'LineWidth',1)
plot(radout.theta([1, end]), [0, 0], 'k')
plot(radout.theta, min(radout.txfm, [], 1), 'Color',oran,'LineWidth',1)
plot([trough.angle, trough.angle], [-trough.max_val, 0], '--','Color',oran,'LineWidth',1)
end
xlim(radout.theta([1,end]))
set(gca, 'XAxisLocation', 'top')
set(gca,'Xticklabel',[])
xlabel('theta (deg)')

end
