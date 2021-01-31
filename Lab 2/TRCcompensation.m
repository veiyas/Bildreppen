function [compensatedRGB] = TRCcompensation(TRC, RGB)
vals = 0:0.01:1;
compensatedRGB(:,:,1) = interp1(TRC(:,:,1), vals, RGB(:,:,1), 'pchip');
compensatedRGB(:,:,2) = interp1(TRC(:,:,2), vals, RGB(:,:,2), 'pchip');
compensatedRGB(:,:,3) = interp1(TRC(:,:,3), vals, RGB(:,:,3), 'pchip');
end

