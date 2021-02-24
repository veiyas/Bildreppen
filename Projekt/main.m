%% Main (Original)
load flagDatabase.mat; load meanDatabase.mat;

% Load file and adjust if neccessary
im = im2double(imread('test_images\test1.jpg'));
im = adjustInput(im);

% Calculate mean L, a, b values for each cell (32x16) in inputImage
meanCellColors = extractCellColors(im);

% Reproduce and show image
repIm = reproduceWithFlags(meanCellColors);

subplot(2,1,1)
imshow(im);
subplot(2,1,2);
imshow(repIm)

% Use object quality measures & S-CIELAB to valdiate resemblense to orginal image
% [snrVal, ssimVal, ssimMap, meanSCIELabDiff, maxSCIELabDiff] = qualityMeasures(im, repIm);


%% Main (with smaller flags prototype)
load flagDatabase.mat; load meanDatabase.mat;

% Load file and adjust if neccessary
im = im2double(imread('test_images\test1.jpg'));
im = adjustInputSmall(im);

% Calculate mean L, a, b values for each cell (32x16) in inputImage
meanCellColors = extractCellColorsSmall(im);

% Reproduce and show image
repIm = reproduceWithFlagsSmall(meanCellColors);

subplot(2,1,1)
imshow(im);
subplot(2,1,2);
imshow(repIm)

% Use object quality measures & S-CIELAB to valdiate resemblense to orginal image
% [snrVal, ssimVal, ssimMap, meanSCIELabDiff, maxSCIELabDiff] = qualityMeasures(im, repIm);