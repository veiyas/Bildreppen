%% Main
load flagDatabase.mat; load meanDatabase.mat;

% Load file and adjust if neccessary
im = im2double(imread('test_images\test2.jpg'));
im = adjustInput(im);

% Calculate mean L, a, b values for each cell (32x16) in inputImage
meanCellColors = extractCellColors(im);

% Reproduce and show image
repIm = reproduceWithFlags(meanCellColors);

subplot(1,2,1)
imshow(im);
subplot(1,2,2);
imshow(repIm)

% Use object quality measures & S-CIELAB to valdiate resemblense to orginal image
[snrVal, ssimVal, ssimMap, meanSCIELabDiff, maxSCIELabDiff] = qualityMeasures(im, repIm);