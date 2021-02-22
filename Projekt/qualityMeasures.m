function [snrVal, ssimVal, ssimMap, meanSCIELabDiff, maxSCIELabDiff] = qualityMeasures(im, repIm)
% Use object quality measures & S-CIELAB to valdiate resemblense to orginal image
whitePoint = [95.05, 100, 108.9];
PPI = 91.79;
d = 19.685;
SPD = PPI * d * tan(pi / 180);

snrVal = snr(im, im - repIm);
[ssimVal, ssimMap] = ssim(im, repIm);
res = scielab(SPD, im, repIm, whitePoint, 'xyz');
meanSCIELabDiff = mean(res(:));
maxSCIELabDiff = max(res(:));

fprintf('\nQuality measures for the reproduced image:\n')
fprintf('     SNR = %4.2f\n', snrVal)
fprintf('     Structural similarity = %4.2f\n', ssimVal);
fprintf('     Mean SCIELab difference = %4.2f\n', meanSCIELabDiff);
fprintf('     Max SCIELab difference = %4.2f\n', maxSCIELabDiff);
end

