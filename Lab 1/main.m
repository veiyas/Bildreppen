%%
load Ad; load Ad2; load illum; load chips20; load M_XYZ2RGB; load xyz; load RGB_raw_D65.mat;
% Ad: spektrala känslighetsfunktioner

% 1.1)
wavelengths = 400:5:700;

% plot(wavelengths, Ad)
% figure;
% plot(wavelengths, Ad2)
% They are a bit similiar but they will have a slight difference

% 1.2)
% RGB_RAW_D65 = Ad' * (chips20 .* CIED65)'; % Eq 7, 20 RGB triplets
% d2 = Ad2' * (chips20 .* CIED65)';
showRGB(RGB_RAW_D65');
showRGB(d2');

% As predicted, they are similar but not equal.
% Ad captures a larger range of wavelengths in [550, 700] and greater magnitude than Ad2
% which results in a brighter red channel. The same thing happens for Ad2
% with the green channel, although with an even larger difference.

%%
% 2.1)
eWhite = ones(1,61);
dNorm1 = Ad' * eWhite'; dNorm1 = 1 ./ dNorm1;
dNorm2 = Ad2' * eWhite'; dNorm2 = 1 ./ dNorm2;

% Norm. factors show how much each wavelength contributes to a channel, the
% channels must be scaled accordingly to not overstate contributions.

% % 2.2)
% showRGB((RGB_RAW_D65.*dNorm1)')
% showRGB((d2.*dNorm2)')

% Negligible differences

% 2.3)
% plot(wavelengths, CIED65)
% figure;
% plot(wavelengths, CIEA)

% Outdoors light contain a lot more blue and green light while indoors
% light contain more red (warmth)

% 2.4)
load RGB_CAL_D65;
load RGB_raw_D65;
dCIEA = Ad' * (chips20 .* CIEA)'; % Eq 7, 20 RGB triplets
% showRGB(RGB_CAL');
% showRGB((dCIEA .* dNorm1)');

% CIEA gives a larger response in the red channel as expected while
% DC65 gives a larger response in the green and blue channels

% 2.5)
DwhiteDC = Ad' * (eWhite .* CIED65)'; DwhiteDC = 1 ./ DwhiteDC;
DwhiteA = Ad' * (eWhite .* CIEA)'; DwhiteA = 1 ./ DwhiteA;

showRGB((RGB_RAW_D65 .* DwhiteDC)');
showRGB((dCIEA .* DwhiteA)');

% Normalized CIEA scales down red and scales up blue, as expected
% by its wavelength properties.
% Normalized DC65 scales down blue and green while scaling up red, as
% evident from its wavelength properties.

%%
load Ad; load Ad2; load illum; load chips20; load M_XYZ2RGB; load xyz; load RGB_CAL; load M_XYZ2RGB; load RGB_raw_D65;

% 3.1)
R = ones(1,61);

XYZ_D65_REF = xyz' * (chips20 .* CIED65)';

xyzWhite = xyz' * (R .* CIED65)';
xyzNormFactor = 100 / xyzWhite(2);

XYZ_D65_REF = XYZ_D65_REF * xyzNormFactor;

% 3.2)
XYZCal = inv(M_XYZ2RGB) * RGB_CAL;

[maxDiff, meanDiff] = labinator(XYZCal, XYZ_D65_REF);

% Max diff = 31.62, Mean diff = 12.64
% On average the color difference will move towards yellow, red or pink

% 3.3)
% wavelengths = 400:5:700;
% plot(wavelengths, Ad)
% figure;
% plot(wavelengths, xyz)

% xyz looks smooth and artificial compared to the camera sensitivity. This
% is expected considering xyz is a standard observer constructed
% experimentally.

% 3.4)
A = pinv(RGB_CAL') * XYZ_D65_REF';

XYZcalEstimate = RGB_CAL'*A;

[maxDiffRaw, meanDiffRaw] = labinator(XYZcalEstimate', XYZ_D65_REF);

% Max diff = -0.73, Mean diff = -45.39
% Overall diff the color difference will always be towards blue, cyan or green

% 3.5)
optiA = Optimize_poly(RGB_RAW_D65, XYZ_D65_REF);
XYZrawOptiEst = Polynomial_regression(RGB_RAW_D65, optiA);

[maxDiffRawOpti, meanDiffRawOpti] = labinator(XYZrawOptiEst, XYZ_D65_REF);

% Max diff = 2.050, Mean diff = 0.020
% Very good mean diff compared to least-squares, max diff slightly larger
% This method is biased to work especially well with the given color samples
% Color difference will on average be negligible













