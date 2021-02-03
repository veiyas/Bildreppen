%% 1.1)
load TRC_display;
vals = 0:0.01:1;

plot(vals, TRCr, 'r'); hold on;
plot(vals, TRCg, 'g')
plot(vals, TRCb, 'b'); hold off;

% Neutral color will have a slightly more blue+red (purple) tint and less green.

%% 1.2)
load Ramp_display; load Ramp_linear;
TRCbundle(:,:,1) = TRCr;
TRCbundle(:,:,2) = TRCg;
TRCbundle(:,:,3) = TRCb;

compensatedRGB = TRCcompensation(TRCbundle, Ramp_display);

subplot(3,1,1)
imshow(Ramp_display) % Slightly purple as predicted
subplot(3,1,2)
imshow(Ramp_linear)
subplot(3,1,3)
imshow(compensatedRGB)

%% 1.3)
gammaR = 2.1; gammaG = 2.4; gammaB = 1.8;
maxR = max(max(Ramp_display(:,:,1)));
maxG = max(max(Ramp_display(:,:,2)));
maxB = max(max(Ramp_display(:,:,3)));

% Eq. 4 for each channel
corrRGB(:,:,1) = maxR * (Ramp_display(:,:,1) ./ maxR) .^ (1/gammaR);
corrRGB(:,:,2) = maxG * (Ramp_display(:,:,2) ./ maxG) .^ (1/gammaG);
corrRGB(:,:,3) = maxB * (Ramp_display(:,:,3) ./ maxB) .^ (1/gammaB);

subplot(3,1,1)
imshow(Ramp_display)
subplot(3,1,2)
imshow(Ramp_linear)
subplot(3,1,3)
imshow(corrRGB)

%% 2.1)
load DLP;

wavelengths = 400:5:700;
plot(wavelengths, DLP)

% Red channel contains relatively little red and a small amount of everything else
% Green channel has two weird distinct peaks and stretches into blue wavelengths
% Blue channel is mostly normal but perhaps a bit narrow band for covering blue colors

%% 2.2) FORWARD MODEL
load RGB_raw; load chips20; load illum; load XYZ_ref; load xyz;

xyzWhite = xyz' * CIED65';
xyzNormFactor = 100 / xyzWhite(2);

SR = DLP*RGB_raw; % Uncalibrated camera RGB-input, projector device dependant result

xyzSR = xyz' * SR * xyzNormFactor; % Till XYZ

[maxDiff_upg22, meanDiff_upg22] = labinator(xyzSR, XYZ_ref)

%% 2.3) FORWARD MODEL
load('RGB_cal.mat'); load xyz;

xyzWhite = xyz' * CIED65';
xyzNormFactor = 100 / xyzWhite(2);

SR = DLP*RGB_cal; % Calibrated camera RGB-input, projector device dependant result

xyzSR = xyz' * SR * xyzNormFactor; % Till XYZ

[maxDiff_upg23, meanDiff_upg23] = labinator(xyzSR, XYZ_ref)

%% 3.1) INVERSE CHARACTERIZATION

k = 100 / sum(CIED65 * xyz(:,2));

% Eq. 3
Acrt = k * xyz' * DLP; % 3X3 matrix for conversion between Independent XYZ to Dependent RGB

Ainv = inv(Acrt);

%% 3.2) INVERSE CHARACTERIZATION
load XYZ_cal; load XYZ_cal_estimate; load XYZ_Optimal_estimate.mat; load XYZ_est.mat;

rgbProjector = Acrt \ XYZ_est;
% showRGB(rgbProjector');

R = ones(1,61);
xyzWhite = xyz' * CIED65';
xyzNormFactor = 100 / xyzWhite(2);

SR = DLP * rgbProjector; % Calibrated camera XYZ-input, projector device dependant result

xyzSR = xyz' * SR * xyzNormFactor; % Till XYZ

[maxDiff_upg32, meanDiff_upg32] = labinator(xyzSR, XYZ_ref)

%% 3.3)
% The max and mean diff is very small compared to the spectral forward model
% Inverse characterization > Spectral forward model
showRGB(RGB_raw')
showRGB(RGB_cal')
showRGB(rgbProjector')

% The rpjector RGB-values are vastly different to the raw/cal RGB values.
% Projector RGB values are built from XYZ-values and XYZ-standard observer
% according to the matrix A_crt.

%% 3.4) INVERSE CHARACTERIZATION

% Clamp values to [0, 1]
rgbProjector(rgbProjector < 0) = 0;
rgbProjector(rgbProjector > 1) = 1;

SR = DLP * rgbProjector;

xyzSR = xyz' * SR * xyzNormFactor;

[maxDiff_upg34, meanDiff_upg34] = labinator(xyzSR, XYZ_ref)

% Max diff is a lot higher, mean diff is slightly higher

% Since we destroy information and we are trying to recreate which
% XYZ-values that leads to the RGB-values, using inverse characterization 
% the results are bound to be different.


%% 3.5)
plot_chrom_sRGB(Acrt) % The projector covers almost all of the sRGB gamut.

% The color can at best be clamped to the closest reproducible value
% (Lowest discernible color difference through L a b perhaps)

%% 3.6)
whichObject = 1;
oneChip = chips20(whichObject,:);

S = DLP * rgbProjector;

ogRGB= oneChip .* CIED65;
SRGB = S(:, whichObject)';

perceivedColorDiff = labinator(rgb2xyz(ogRGB*DLP)', rgb2xyz(SRGB*DLP)')

wavelengths = 400:5:700;
plot(wavelengths, SRGB); hold on;
plot(wavelengths, oneChip);

% Looking at spectral similarity, the reproduction accuracy is very bad,
% only wavelength lambda~625 is reproduced correctly

% The perceived color difference (=85.04) is high as well which reinforces
% that this is a bad reproduction.

%%

for i = 1:20
    disp(i)
    [maxDiff, meanDiff] = labinator(xyzSR(:,i), XYZ_ref(:,i))
end

% Object 1 is best





