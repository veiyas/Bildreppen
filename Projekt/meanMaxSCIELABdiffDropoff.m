%% Plot how much the mean and max S-CIELAB differences change with distance
im = adjustInput(im2double(imread('test_images\test2.jpg')));
repIm = adjustInput(im2double(imread('renders\SCIELAB\bernieSCIE-snr=2.83-ssim=0.04-meanSCIE=6.53-maxSCIE=23.20.png')));

whitePoint = [95.05, 100, 108.9];
PPI = 91.79;
centimeters = 1:200;
meanResults = [];
maxResults = [];

for i = 1:1:200
    SPD = PPI * centimeters(i)/2.54 * tan(pi / 180);
    res = scielab(SPD, rgb2xyz(im), rgb2xyz(repIm), whitePoint, 'xyz');
    meanResults(i) = mean(res(:));
    maxResults(i) = max(res(:));
end

plot(centimeters, meanResults)
hold on;
plot(centimeters, maxResults)
legend('Mean S-CIELAB difference', 'Max S-CIELAB difference');
title('Mean and max S-CIELAB differences plotted against centimers, PPI = 91.79');
