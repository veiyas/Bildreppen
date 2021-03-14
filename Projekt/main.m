%% Main with Lab difference
load flagDatabase.mat; load meanLabDatabase.mat;

% Load file and adjust if neccessary
im = im2double(imread('test_images\test8.jpg'));
im = adjustInputSmall(im);

% Calculate mean L, a, b values for each cell (16x8) in inputImage
meanLabCellColors = extractLabCellColorsSmall(im);

% Reproduce and show image
repIm = reproduceWithLabFlagsSmall(meanLabCellColors, flagDatabase, meanLabDatabase);

subplot(2,1,1)
imshow(im);
subplot(2,1,2);
imshow(repIm)

% Use object quality measures & S-CIELAB to valdiate resemblense to orginal image
[snrVal, ssimVal, ssimMap, meanSCIELabDiff, maxSCIELabDiff] = qualityMeasures(im, repIm);

%% Main with SCIELab difference
load flagDatabase.mat; load meanXYZDatabase.mat;
 
% Load file and adjust if neccessary
im = im2double(imread('test_images\test9.jpg'));
im = adjustInputSmall(im);

% Calculate mean L, a, b values for each cell (16x8) in inputImage
meanXYZCellColors = extractXYZCellColorsSmall(im);

% Reproduce and show image
repIm = reproduceWithSCIELabFlagsSmall(meanXYZCellColors, flagDatabase, meanXYZDatabase);

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

%% Jolly roger and image specific optimisation
load flagDatabase.mat; load meanLabDatabase.mat; load meanXYZDatabase.mat;

% Load jolly roger flag into relevant databases
jr = im2double(imread('flags\originals\jollyroger.png'));
jr_LAB = rgb2lab(jr);
jr_XYZ = rgb2xyz(jr);

meanJR_LAB = mean(mean(jr_LAB));
meanJR_LAB = [meanJR_LAB(:,:,1) meanJR_LAB(:,:,2) meanJR_LAB(:,:,3)];

meanJR_XYZ = mean(mean(jr_XYZ));
meanJR_XYZ = [meanJR_XYZ(:,:,1) meanJR_XYZ(:,:,2) meanJR_XYZ(:,:,3)];

flagDatabaseOpti = cat(3, flagDatabase, jr);
meanLabDatabaseOpti = cat(2, meanLabDatabase, meanJR_LAB);
meanXYZDatabaseOpti = cat(2, meanXYZDatabase, meanJR_XYZ);

% REMOVE IMAGES HERE, SOMEHOW

im = im2double(imread('test_images\test8.jpg'));
im = adjustInputSmall(im);
meanLabCellColors = extractLabCellColorsSmall(im);

repIm = reproduceWithLabFlagsSmall(meanLabCellColors, flagDatabaseOpti, meanLabDatabaseOpti);
imshow(repIm);









                                                