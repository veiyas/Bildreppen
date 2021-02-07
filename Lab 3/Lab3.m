%% 1)
load Dell.mat; load Inkjet.mat;

plot_chrom(XYZdell, 'r')
plot_chrom(XYZinkjet, 'b')

% Dell screen is better for red and blue
% Inkjet is better for green and yellow

%% 2.1)
im = im2double(imread('peppers_gray.tif'));

% Interpolation
imInterp = imresize(imresize(im,0.25,'nearest'),4,'nearest');
interpSNR = mysnr(im, im - imInterp)

% SNR = 17.10, which seems to be too good considering the image is awful.

% Halftoning
imHT = im2double(dither(im));
imThresh = im2double(im >= 0.5);
HTSNR = mysnr(im, im - imHT)
threshSNR = mysnr(im, im - imThresh)

% Error diffused image looks the best but has the worst SNR.
% Tresholded image looks awful but still has SNR=2.97.
% The metric don't correlate to our judgement of the quality. One of the
% reasons is that humans percieve the image as a whole while SNR and
% mathematical metrics examine the images pixel by pixel.

%% 2.2)
load RGB_raw.mat; load XYZ_ref.mat;
im = im2double(imread('peppers_color.tif'));

htR = im2double(dither(im(:,:,1)));
htG = im2double(dither(im(:,:,2)));
htB = im2double(dither(im(:,:,3)));
imHT(:,:,1) = htR;
imHT(:,:,2) = htG;
imHT(:,:,3) = htB;

threshR = im2double(im(:,:,1) >= 0.5);
threshG = im2double(im(:,:,2) >= 0.5);
threshB = im2double(im(:,:,3) >= 0.5);
imThresh(:,:,1) = threshR;
imThresh(:,:,2) = threshG;
imThresh(:,:,3) = threshB;

refLAB = rgb2lab(im);
HTLAB = rgb2lab(imHT);
threshLAB = rgb2lab(imThresh);

HTcolorDiff = (refLAB - HTLAB).^2;
HTcdSum = sqrt(sum(HTcolorDiff));

HTmaxDiff = max(HTcdSum(:))
HTmeanDiff = mean(HTcdSum(:))

threshcolorDiff = (refLAB - threshLAB).^2;
threshcdSum = sqrt(sum(threshcolorDiff));

threshmaxDiff = max(threshcdSum(:))
threshmeanDiff = mean(threshcdSum(:))

% HT: maxDiff = 1370, meanDiff = 1034
% Thresh: maxDiff = 1014, meanDiff = 675

% Halftoned image has the largest differences but is still the best looking
% image. However, the math says the thresholded image should be a better
% representation.

%% 3.1)
im = im2double(imread('peppers_gray.tif'));

subplot(1,3,1);
imshow(im);
subplot(1,3,2);
imshow(imHT);
subplot(1,3,3);
imshow(imThresh);

% Halftoning
imHT = im2double(dither(im));
imThresh = im2double(im >= 0.5);
HTSNR = snr_filter(im, im - imHT)
threshSNR = snr_filter(im, im - imThresh)

% Diffusion now has a better SNR which correlates to the higher percieved
% image quality. The thresholded image has a lower SNR which is logical
% considering if we didnt know what the reference image is there is no way
% to distinguish what the thresholded image depicts.

%% 3.1.1)

f=MFTsp(15,0.0847,500);
% s=conv2(X,f,'same');
% n=conv2(Y,f,'same');
% Ögats filter är applicerat till "noise"-en (skillnaden mellan originalbilden och rasterbilden)

load RGB_raw.mat; load XYZ_ref.mat;
im = im2double(imread('peppers_color.tif'));

htR = im2double(conv2(dither(im(:,:,1)), f, 'same')); htR = (htR > 0) .* htR;
htG = im2double(conv2(dither(im(:,:,2)), f, 'same')); htG = (htG > 0) .* htG;
htB = im2double(conv2(dither(im(:,:,3)), f, 'same')); htB = (htB > 0) .* htB;
imHT(:,:,1) = htR;
imHT(:,:,2) = htG;
imHT(:,:,3) = htB;

threshR = im2double(conv2(im(:,:,1) >= 0.5, f, 'same')); threshR = (threshR > 0) .* threshR;
threshG = im2double(conv2(im(:,:,2) >= 0.5, f, 'same')); threshG = (threshG > 0) .* threshG;
threshB = im2double(conv2(im(:,:,3) >= 0.5, f, 'same')); threshB = (threshB > 0) .* threshB;
imThresh(:,:,1) = threshR;
imThresh(:,:,2) = threshG;
imThresh(:,:,3) = threshB;

refLAB = rgb2lab(im);
HTLAB = rgb2lab(imHT);
threshLAB = rgb2lab(imThresh);

HTcolorDiff = (refLAB - HTLAB).^2;
HTcdSum = sqrt(sum(HTcolorDiff));

HTmaxDiff = max(HTcdSum(:))
HTmeanDiff = mean(HTcdSum(:))

threshcolorDiff = (refLAB - threshLAB).^2;
threshcdSum = sqrt(sum(threshcolorDiff));

threshmaxDiff = max(threshcdSum(:))
threshmeanDiff = mean(threshcdSum(:))

% HT: maxDiff = 463.25, meanDiff = 288.12
% Thresh: maxDiff = 1002, meanDiff = 645

% The diffused image is a lot better after the eye filtering is applied.
% This correlates to the percieved image quality as well.

%% 4.1)
im = im2double(imread('peppers_color.tif'));
whitePoint = [95.05, 100, 108.9];
imInterp = imresize(imresize(im,0.25,'nearest'),4,'nearest');

XYZim = rgb2xyz(im);
XYZinterp = rgb2xyz(im);

PPI = 189.91;
d = 19.685;
SPD = PPI * d * tan(pi / 180);

res = scielab(SPD, XYZim, XYZim - XYZinterp, whitePoint, 'xyz');
max(res(:))

%% 4.2.1)
load colorhalftones.mat;

PPI = 189.91;
d = 19.685;
SPD = PPI * d * tan(pi / 180);

subplot(1,2,1);
imshow(c1);
subplot(1,2,2);
imshow(c2);

c1SCIE = scielab(SPD, rgb2xyz(c1));
c2SCIE = scielab(SPD, rgb2xyz(c2));
c1std = std2(c1SCIE)
c2std = std2(c2SCIE)

% C2 looks slightly more grainy however the SCIELAB differences are so
% small there barely is any differentiation in graininess between them.

%% 4.2.2)

subplot(1,3,1);
imshow(c3);
subplot(1,3,2);
imshow(c4);
subplot(1,3,3);
imshow(c5);

c3std = std2(scielab(SPD, rgb2xyz(c3)));
c4std = std2(scielab(SPD, rgb2xyz(c4)));
c5std = std2(scielab(SPD, rgb2xyz(c5)));
c3std
c4std
c5std

% The difference are on thousands and smaller ???

%% 5.1) Distorsion A
im = im2double(imread('peppers_gray.tif'));
imDist1 = im;
imDist2 = im;

oddRows = im(1:2:end,:,:); oddRows = oddRows + 0.1;
evenRows = im(2:2:end,:,:); evenRows = evenRows - 0.1;

imDist1(1:2:end,:,:) = oddRows;
imDist1(2:2:end,:,:) = evenRows;

imDist2(1:size(im,1)/2,:,:) = imDist2(1:size(im,1)/2,:,:) + 0.1;
imDist2(size(im,1)/2:end,:,:) = imDist2(size(im,1)/2:end,:,:) - 0.1;

[ssimVal_1, ssimMap_1] = ssim(imDist1, im);
[ssimVal_2, ssimMap_2] = ssim(imDist2, im);

% Total distortion is the same in the two cases, therefore the SNR values
% are equal

% ssimVal_1 = 0.21, which means it's pretty far from the origal image.
% Areas with high spatial frequency are highlighted in the ssimmap which
% means these areas are the most similar to the original image.

% ssimVal_2 = 0.85 which is very good. The ssimMap shows that almost all
% points in the image are the same except for the seam splitting the
% distortion in the middle of the image and darker regions.

%% 5.2) Distorsion B
imDist1 = im + 0.2*(rand(size(im)) - 0.5);
imDist2 = conv2(im, fspecial('gauss', 21, 10), 'same');

snrDist1 = snr(im, im - imDist1)
snrDist2 = snr(im, im - imDist2)

% Dist1 > Dist 2 according to SNR

[ssimVal_1, ssimMap_1] = ssim(imDist1, im);
[ssimVal_2, ssimMap_2] = ssim(imDist2, im);

% ssimVal_1 = 0.43, it's passable at best.
% Areas with high spatial frequency are highlighted in the ssimmap which
% means these areas are the most similar to the original image. Low
% frequency are relatively prevalent as well.

% ssimVal_2 = 0.67 which is OK. The ssimMap shows that low frequency
% areas are mostly unchanged while high frequency areas unsimilar.

% SNR and ssim values are contradictionary for this image!
