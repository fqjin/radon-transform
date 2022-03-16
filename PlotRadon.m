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
%   logscale (bool): optional, default true
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PlotRadon(fignum, data, radout, peak, p_out, trough, t_out, logscale)
if fignum > 0
    figure(fignum)
    clf
end
if ~exist('logscale', 'var')
    logscale = true;
end
trough_mode = exist('trough','var') && exist('t_out','var') ...
              && ~isempty(trough) && ~isempty(t_out);
blue = [0, 0.4470, 0.7410];
oran = [0.8500, 0.3250, 0.0980];

tiledlayout(3, 5, 'TileSpacing', 'tight', 'Padding', 'compact');
nexttile(1, [2, 2])
imagesc(data.tMsec, data.xMm, data.data)
hold on
plot(p_out.times, data.xMm, 'k', 'LineWidth', 2)
if trough_mode
plot(t_out.times, data.xMm, 'w', 'LineWidth', 2)
end
xlabel('Time (ms)');
ylabel('Lateral (mm)');
colorbar
if ~trough_mode
title(sprintf('Speed = %.2f m/s', p_out.speed))
else
title(sprintf('Peak=%.2f m/s , Trough=%.2f m/s', p_out.speed, t_out.speed))
end

nexttile(3, [2, 2])
radout.theta = flip(radout.theta);
radout.txfm = fliplr(radout.txfm);
speed_list = data.dxdt .* cotd(radout.theta);
h = pcolor(speed_list, radout.rp, radout.txfm);
set(h, 'EdgeColor', 'none')
hold on
plot(p_out.speed, peak.rad_pos, '.k', 'MarkerSize', 12)
if trough_mode
plot(t_out.speed, trough.rad_pos, '.w', 'MarkerSize', 12)
end
title('Radon Transform')
set(gca, 'YDir', 'reverse')
set(gca, 'YAxisLocation', 'right')
if logscale
    set(gca, 'XScale', 'log')
end

nexttile(5, [2, 1])
max_line = max(radout.txfm, [], 2);
plot(max_line, radout.rp, 'Color',blue,'LineWidth',1)
hold on
plot([min(max_line), peak.max_val], [1,1].*peak.rad_pos, '--','Color',blue,'LineWidth',1)
if trough_mode
min_line = min(radout.txfm, [], 2);
plot(min_line, radout.rp, 'Color',oran,'LineWidth',1)
plot([-trough.max_val, max(min_line)], [1,1].*trough.rad_pos, '--','Color',oran,'LineWidth',1)
end
ylim(radout.rp([1,end]))
ylabel('Radial Position')
set(gca, 'YDir', 'reverse')

nexttile(13, [1, 2])
max_line = max(radout.txfm, [], 1);
plot(speed_list, max_line,'Color',blue,'LineWidth',1)
hold on
plot([1,1].*p_out.speed, [min(max_line), peak.max_val], '--','Color',blue,'LineWidth',1)
if trough_mode
min_line = min(radout.txfm, [], 1);
plot(speed_list, min_line, 'Color',oran,'LineWidth',1)
plot([1,1].*t_out.speed, [-trough.max_val, max(min_line)], '--','Color',oran,'LineWidth',1)
end
xlim(speed_list([1,end]))
xlabel('Speed (m/s)')
set(gca, 'XAxisLocation', 'top')
if logscale
    set(gca, 'XScale', 'log')
end

end
