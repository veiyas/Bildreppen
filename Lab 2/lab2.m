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
% D_r = D_max(D'_r/D_max)^1/Y_r % (4)

gammaR = 2.1; gammaG = 2.4; gammaB = 1.8;
maxR = max(max(Ramp_display(:,:,1)));
maxG = max(max(Ramp_display(:,:,2)));
maxB = max(max(Ramp_display(:,:,3)));

corrRGB(:,:,1) = maxR * (Ramp_display(:,:,1) ./ maxR) .^ (1/gammaR);
corrRGB(:,:,2) = maxG * (Ramp_display(:,:,2) ./ maxG) .^ (1/gammaG);
corrRGB(:,:,3) = maxB * (Ramp_display(:,:,3) ./ maxB) .^ (1/gammaB);

subplot(2,1,1)
imshow(corrRGB)
subplot(2,1,2)
imshow(Ramp_linear)

%% 2.1)
load DLP;

wavelengths = 400:5:700;
plot(wavelengths, DLP)

% Red channel contains relatively little red and a small amount of everything else
% Green channel has two weird distinct peaks and stretches into blue wavelengths
% Blue channel is mostly normal but perhaps a bit narrow band for covering blue colors

%% 2.2)
load RGB_raw; load chips20; load illum; load XYZ_ref; load xyz;

% xyzWhite = xyz' * (R .* CIED65)';
% xyzNormFactor = 100 / xyzWhite(2);

R = ones(1,61);
SR = DLP*RGB_raw; % Eq. 2

i = 1;
xyzDifference = zeros(20, 2);
for k = 1:20
    [maxDiff, meanDiff] = labinator(SR(i:i+3, :), XYZ_ref);
    xyzDifference(k, :) = [maxDiff meanDiff];
    i = i + 3;
end
% Mean max-diff = 111.10, Mean mean-diff = 64.70

%% 2.3)
load('RGB_cal.mat')

i = 1;
xyzDifference = zeros(20, 2);
for k = 1:20
    [maxDiff, meanDiff] = labinator(SR(i:i+3, :), XYZ_ref);
    xyzDifference(k, :) = [maxDiff meanDiff];
    i = i + 3;
end
% Mean max-diff = 110.046, Mean mean-diff = 64.22

%% 3.1)

k = 100 / sum(CIED65 * xyz(:,2));

Acrt = k * xyz' * DLP; %3X3 matrix for conversion between Independent to Dependent

Ainv = inv(Acrt);

%% 3.2)
load XYZ_cal; load XYZ_cal_estimate;

rgbProjector = Acrt \ XYZcalEstimate'; % Fråga om vilken XYZ som ska användas
% showRGB(rgbProjector');

SR = DLP * rgbProjector;
i = 1;
xyzDifference = zeros(20, 2);
for k = 1:20
    [maxDiff, meanDiff] = labinator(SR(i:i+3, :), XYZ_ref);
    xyzDifference(k, :) = [maxDiff meanDiff];
    i = i + 3;
end
% Mean max-diff = 110.046, Mean mean-diff = 64.22, same as (2.3) ???

%% 3.3)
% The max and mean differences are identical to (2.3) even though
% a different spectral radiance is used.

% Ask for help why this happens (???)

%% 3.4)

% Clamp values to [0, 1]
rgbProjector(rgbProjector < 0) = 0;
rgbProjector(rgbProjector > 1) = 1;

SR = DLP * rgbProjector;
i = 1;
xyzDifference = zeros(20, 2);
for k = 1:20
    [maxDiff, meanDiff] = labinator(SR(i:i+3, :), XYZ_ref);
    xyzDifference(k, :) = [maxDiff meanDiff];
    i = i + 3;
end
% Mean max-diff = 109.91, Mean mean-diff = 64.20
% Results are barely any better, is this correct ???


%% 3.5)
plot_chrom_sRGB(Acrt) % The projector covers almost all of the sRGB gamut.

% The color can at best be clamped to the closest reproducible value (???)

%% 3.6)

load XYZ_Optimal_estimate.mat;

wavelengths = 400:5:700;
plot(wavelengths, DLP); hold on;
plot(wavelengths, CIED65);









