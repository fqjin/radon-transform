%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Manually draw a mask to select desired data
%
% Arguments:
%   data (struct): containing {data, xMm, tMsec}
%
% Returns:
%   mask (matrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mask = MaskManual(data, options)
arguments
    data struct
    options.caxis (1,2) = [-inf, inf]
    options.titletext string = ''
end
figure
imagesc(data.tMsec, data.xMm, data.data)
caxis(options.caxis)
title(options.titletext)
xlabel('Time (ms)')
ylabel('Lateral (mm)')
roi = images.roi.Freehand;
draw(roi)
mask = roi.createMask();
