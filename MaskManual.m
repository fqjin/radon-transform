%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Manually draw a mask to select desired data
%
% Arguments:
%   data (struct): containing {data, xMm, tMsec}
%
% Returns:
%   mask (matrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mask = MaskManual(data)
figure
imagesc(data.tMsec, data.xMm, data.data)
xlabel('Time (ms)')
ylabel('Lateral (mm)')
roi = images.roi.Freehand;
draw(roi)
mask = roi.createMask();
