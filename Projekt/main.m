%% Main
load flagDatabase.mat; load meanDatabase.mat;

% Load file and adjust if neccessary
im = im2double(imread('test_images\example_image_small.jpg'));
im = adjustInput(im);

% Calculate mean L, a, b values for each cell (32x16) in inputImage
meanCellColors = extractCellColors(im);

% Reproduce image
repIm = reproduceWithFlags(meanCellColors);

subplot(1,2,1)
imshow(im);
subplot(1,2,2);
imshow(repIm)

%Use Snr, S-CIELAB to valdiate resemblense to orginal image

%%
inputImage = imread('test_images\example_image.jpg');
inputImage = adjustInput(inputImage);

