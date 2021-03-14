function [snrVal, ssimVal, ssimMap, meanDiff_Normal, maxDiff_Normal] = qualityMeasures(im, repIm)
% Use object quality measures & S-CIELAB to valdiate resemblense to orginal image
whitePoint = [95.05, 100, 108.9];

% PPI for 24 inch monitors
PPI_HD = 91.79;
PPI_4K = 183;

d_Close = 7.874; % 20cm viewing distance
d_Normal = 19.685; % 50cm viewing distance
d_Far = 39.370; % 100cm viewing distance

SPD_Close  = PPI_HD * d_Close * tan(pi / 180);
SPD_Normal = PPI_HD * d_Normal * tan(pi / 180);
SPD_Far = PPI_HD * d_Far * tan(pi / 180);

SPD_4K_Close = PPI_4K * d_Close * tan(pi / 180);
SPD_4K_Normal = PPI_4K * d_Normal * tan(pi / 180);
SPD_4K_Far = PPI_4K * d_Far * tan(pi / 180);

snrVal = snr(im, im - repIm);
[ssimVal, ssimMap] = ssim(im, repIm);

res_Close = scielab(SPD_Close, im, repIm, whitePoint, 'xyz');
meanDiff_Close = mean(res_Close(:));
maxDiff_Close = max(res_Close(:));

res_Normal = scielab(SPD_Normal, im, repIm, whitePoint, 'xyz');
meanDiff_Normal = mean(res_Normal(:));
maxDiff_Normal = max(res_Normal(:));

res_Far = scielab(SPD_Far, im, repIm, whitePoint, 'xyz');
meanDiff_Far = mean(res_Far(:));
maxDiff_Far = max(res_Far(:));

res_4K_Close = scielab(SPD_4K_Close, im, repIm, whitePoint, 'xyz');
meanDiff_4K_Close = mean(res_4K_Close(:));
maxDiff_4K_Close = max(res_4K_Close(:));

res_4K_Normal = scielab(SPD_4K_Normal, im, repIm, whitePoint, 'xyz');
meanDiff_4K_Normal = mean(res_4K_Normal(:));
maxDiff_4K_Normal = max(res_4K_Normal(:));

res_4K_Far = scielab(SPD_4K_Far, im, repIm, whitePoint, 'xyz');
meanDiff_4K_Far = mean(res_4K_Far(:));
maxDiff_4K_Far = max(res_4K_Far(:));

fprintf('\nQuality measures for the reproduced image:\n')
fprintf('     SNR = %4.2f\n', snrVal)
fprintf('     Structural similarity = %4.2f\n', ssimVal);
fprintf('     Mean SCIELab, 20cm & 91.79 ppi = %4.2f\n', meanDiff_Close);
fprintf('     Max SCIELab, 20cm & 91.79 ppi = %4.2f\n', maxDiff_Close);
fprintf('     Mean SCIELab, 50cm & 91.79 ppi = %4.2f\n', meanDiff_Normal);
fprintf('     Max SCIELab, 50cm & 91.79 ppi = %4.2f\n', maxDiff_Normal);
fprintf('     Mean SCIELab, 100cm & 91.79 ppi = %4.2f\n', meanDiff_Far);
fprintf('     Max SCIELab, 100cm & 91.79 ppi = %4.2f\n', maxDiff_Far);
fprintf('     Mean SCIELab, 20cm & 183 ppi = %4.2f\n', meanDiff_4K_Close);
fprintf('     Max SCIELab, 20cm & 183 ppi = %4.2f\n', maxDiff_4K_Close);
fprintf('     Mean SCIELab, 50cm & 183 ppi = %4.2f\n', meanDiff_4K_Normal);
fprintf('     Max SCIELab, 50cm & 183 ppi = %4.2f\n', maxDiff_4K_Normal);
fprintf('     Mean SCIELab, 100cm & 183 ppi = %4.2f\n', meanDiff_4K_Far);
fprintf('     Max SCIELab, 100cm & 183 ppi = %4.2f\n', maxDiff_4K_Far);
end

