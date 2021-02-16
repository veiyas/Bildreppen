%% 1)
load Dell.mat; load Inkjet.mat;

plot_chrom(XYZdell, 'r')
plot_chrom(XYZinkjet, 'b')

% Dell screen is better for red and blue
% Inkjet is better for green and yellow

%% 2.1.1)
im = im2double(imread('peppers_gray.tif'));

% Interpolation
imInterp = imresize(imresize(im,0.25,'bicubic'),4,'bicubic');

subplot(1,2,1);
imshow(im);
subplot(1,2,2);
imshow(imInterp);

interpSNR = mysnr(im, im - imInterp)

% SNR = 17.10, which seems to be too good considering the image is awful.

%% 2.1.2)
% Halftoning
imErrDiffused = im2double(dither(im));
imThresh = im2double(im >= 0.5);

subplot(1,2,1);
imshow(imErrDiffused);
subplot(1,2,2);
imshow(imThresh);

HTSNR = mysnr(im, im - imErrDiffused)
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
imErrDiffused(:,:,1) = htR;
imErrDiffused(:,:,2) = htG;
imErrDiffused(:,:,3) = htB;

threshR = im2double(im(:,:,1) >= 0.5);
threshG = im2double(im(:,:,2) >= 0.5);
threshB = im2double(im(:,:,3) >= 0.5);
imThresh(:,:,1) = threshR;
imThresh(:,:,2) = threshG;
imThresh(:,:,3) = threshB;

refLAB = rgb2lab(im);
errDiffLAB = rgb2lab(imErrDiffused);
threshLAB = rgb2lab(imThresh);

errDiffColorDiff = sqrt((refLAB(:,:,1) - errDiffLAB(:,:,1)).^2 + (refLAB(:,:,2) - errDiffLAB(:,:,2)).^2 + (refLAB(:,:,3) - errDiffLAB(:,:,3)).^2);
errDiffMeanDiff = mean(mean(errDiffColorDiff))

threshcolorDiff = sqrt((refLAB(:,:,1) - threshLAB(:,:,1)).^2 + (refLAB(:,:,2) - threshLAB(:,:,2)).^2 + (refLAB(:,:,3) - threshLAB(:,:,3)).^2);
threshMeanDiff = mean(mean(threshcolorDiff))

% Error diffusion meanDiff = 72.84
% Threshhold meanDiff = 50.15

% Halftoned image has the largest differences but is still the best looking
% image. However, the math says the thresholded image should be a better
% representation.

%% 3.1)
im = im2double(imread('peppers_gray.tif'));

% Halftoning
imErrDiffused = im2double(dither(im));
imThresh = im2double(im >= 0.5);

subplot(1,3,1);
imshow(im);
subplot(1,3,2);
imshow(imErrDiffused);
subplot(1,3,3);
imshow(imThresh);

HTSNR = snr_filter(im, im - imErrDiffused)
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
imErrDiffused(:,:,1) = htR;
imErrDiffused(:,:,2) = htG;
imErrDiffused(:,:,3) = htB;

threshR = im2double(conv2(im(:,:,1) >= 0.5, f, 'same')); threshR = (threshR > 0) .* threshR;
threshG = im2double(conv2(im(:,:,2) >= 0.5, f, 'same')); threshG = (threshG > 0) .* threshG;
threshB = im2double(conv2(im(:,:,3) >= 0.5, f, 'same')); threshB = (threshB > 0) .* threshB;
imThresh(:,:,1) = threshR;
imThresh(:,:,2) = threshG;
imThresh(:,:,3) = threshB;

subplot(1,3,1);
imshow(im);
subplot(1,3,2);
imshow(imErrDiffused);
subplot(1,3,3);
imshow(imThresh);

refLAB = rgb2lab(im);
errDiffLAB = rgb2lab(imErrDiffused);
threshLAB = rgb2lab(imThresh);

errDiffColorDiff = sqrt((refLAB(:,:,1) - errDiffLAB(:,:,1)).^2 + (refLAB(:,:,2) - errDiffLAB(:,:,2)).^2 + (refLAB(:,:,3) - errDiffLAB(:,:,3)).^2);
errDiffMeanDiff = mean(mean(errDiffColorDiff))

threshcolorDiff = sqrt((refLAB(:,:,1) - threshLAB(:,:,1)).^2 + (refLAB(:,:,2) - threshLAB(:,:,2)).^2 + (refLAB(:,:,3) - threshLAB(:,:,3)).^2);
threshMeanDiff = mean(mean(threshcolorDiff))

% Error diffusion meanDiff = 20.19
% Threshold meanDiff = 48.03

% The diffused image is a lot better after the eye filtering is applied.
% This correlates to the percieved image quality as well.

%% 4.1) S-CIELab Full-reference
im = im2double(imread('peppers_color.tif'));
whitePoint = [95.05, 100, 108.9];
imInterp = imresize(imresize(im,0.25,'bicubic'),4,'bicubic');

XYZim = rgb2xyz(im);
XYZinterp = rgb2xyz(imInterp);

subplot(1,2,1);
imshow(im);
subplot(1,2,2);
imshow(imInterp);

PPI = 91.79;
d = 19.685;
SPD = PPI * d * tan(pi / 180);

res = scielab(SPD, XYZim, XYZinterp, whitePoint, 'xyz');
meanDiff = mean(res(:))
maxDiff = max(res(:))

% meanDiff = 0.23, % maxDiff = 5.86

% The distortion doesn't distort the color directly but rather consolidates and moves color
% values around in a square-like manner. S-CIELab also applies low-pass
% filtering to mimic the eye which eleminates a lot of the harsh borders
% which manifests from the distortion. Therefore, it's not a surprise the
% mean and max differences are small.

% We feel like the values are too small since the image has been so
% heavily distorted
%% 4.2.1) S-CIELab No-reference
load colorhalftones.mat;

PPI = 91.79;
d = 8;
SPD = PPI * d * tan(pi / 180);

subplot(1,2,1);
imshow(c1);
subplot(1,2,2);
imshow(c2);

c1SCIE = scielab(SPD, rgb2xyz(c1));
c2SCIE = scielab(SPD, rgb2xyz(c2));
c1std = std2(c1SCIE(:,:,1)) + std2(c1SCIE(:,:,2)) + std2(c1SCIE(:,:,3))
c2std = std2(c2SCIE(:,:,1)) + std2(c2SCIE(:,:,2)) + std2(c2SCIE(:,:,3))

% They both look equally grainy but differently structured. The blue
% squares in C1 are a bit more noticable. The SCIELAB differences are so
% small there barely is any differentiation in mathematical graininess between them as well.

%% 4.2.2)

subplot(1,3,1);
imshow(c3);
subplot(1,3,2);
imshow(c4);
subplot(1,3,3);
imshow(c5);

c3SCIE = scielab(SPD, rgb2xyz(c3));
c4SCIE = scielab(SPD, rgb2xyz(c4));
c5SCIE = scielab(SPD, rgb2xyz(c5));

c3std = std2(c3SCIE(:,:,1)) + std2(c3SCIE(:,:,2)) + std2(c3SCIE(:,:,3))
c4std = std2(c4SCIE(:,:,1)) + std2(c4SCIE(:,:,2)) + std2(c4SCIE(:,:,3))
c5std = std2(c5SCIE(:,:,1)) + std2(c5SCIE(:,:,2)) + std2(c5SCIE(:,:,3))

% Display values
c3std
c4std
c5std

% The difference are in thousands and smaller which means the images are
% pretty close in graininess. The images also feel very similar in
% graininess to our eyes, even if the images have been rasterized
% differently.

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

subplot(1,3,1);
imshow(im);
subplot(1,3,2);
imshow(imDist1);
subplot(1,3,3);
imshow(imDist2);

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

subplot(1,3,1);
imshow(im);
subplot(1,3,2);
imshow(imDist1);
subplot(1,3,3);
imshow(imDist2);

snrDist1 = snr(im, im - imDist1)
snrDist2 = snr(im, im - imDist2)

% Dist1 > Dist 2 according to SNR which is also what we percieve.

[ssimVal_1, ssimMap_1] = ssim(imDist1, im);
[ssimVal_2, ssimMap_2] = ssim(imDist2, im);

% ssimVal_1 = 0.43, it's passable at best.
% Areas with high spatial frequency are highlighted in the ssimmap which
% means these areas are the most similar to the original image. Low
% frequency are relatively prevalent as well.

% ssimVal_2 = 0.67 which is OK. The ssimMap shows that low frequency
% areas are mostly unchanged while high frequency areas unsimilar.

% SNR and ssim values are contradictionary for this image!
