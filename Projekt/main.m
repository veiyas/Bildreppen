%% Main with Lab difference
 
% Load file and adjust if neccessary
im = im2double(imread('test_images\test5.jpg'));
im = adjustInputSmall(im);

% Calculate mean L, a, b values for each cell (16x8) in inputImage
meanLabCellColors = extractLabCellColorsSmall(im);

% Reproduce and show image
repIm = reproduceWithLabFlagsSmall(meanLabCellColors);

subplot(2,1,1)
imshow(im);
subplot(2,1,2);
imshow(repIm)

% Use object quality measures & S-CIELAB to valdiate resemblense to orginal image
[snrVal, ssimVal, ssimMap, meanSCIELabDiff, maxSCIELabDiff] = qualityMeasures(im, repIm);

%% Main with SCIELab difference
 
% Load file and adjust if neccessary
im = im2double(imread('test_images\test9.jpg'));
im = adjustInputSmall(im);

% Calculate mean L, a, b values for each cell (16x8) in inputImage
meanXYZCellColors = extractXYZCellColorsSmall(im);

% Reproduce and show image
repIm = reproduceWithSCIELabFlagsSmall(meanXYZCellColors);

subplot(2,1,1)
imshow(im);
subplot(2,1,2);
imshow(repIm)

% Use object quality measures & S-CIELAB to valdiate resemblense to orginal image
[snrVal, ssimVal, ssimMap, meanSCIELabDiff, maxSCIELabDiff] = qualityMeasures(im, repIm);

%% Colour Optimization
load meanLabDatabase.mat; load flagDatabase.mat;
[optiFlagDatabase, OptiMeanLabDatabase] = optimiseColors(flagDatabase, meanLabDatabase, 130);
plot_Lab(4, OptiMeanLabDatabase, 1, 'r', 50, 0)

save('optiFlagDatabase.mat', 'optiFlagDatabase');
save('OptiMeanLabDatabase.mat', 'OptiMeanLabDatabase');

%% Reproduction via color optimization

% Load file and adjust if neccessary
im = im2double(imread('test_images\test5.jpg'));
im = adjustInputSmall(im);

% Calculate mean L, a, b values for each cell (16x8) in inputImage
meanLabCellColors = extractLabCellColorsSmall(im);

% Reproduce and show image
repIm = reproduceWithOptimisedFlags(meanLabCellColors);
% 
% subplot(2,1,1)
% imshow(im);
% subplot(2,1,2);
imshow(repIm)

% Use object quality measures & S-CIELAB to valdiate resemblense to orginal image
[snrVal, ssimVal, ssimMap, meanSCIELabDiff, maxSCIELabDiff] = qualityMeasures(im, repIm);
                                                