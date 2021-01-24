%%
load Ad; load Ad2; load illum; load chips20; load M_XYZ2RGB;
% Ad: spektrala känslighetsfunktioner

wavelengths = 400:5:700;

plot(wavelengths, Ad)
figure;
plot(wavelengths, Ad2)
% 1.1) They are similar but they will have a slight difference

RGB_RAW_D65 = Ad' * (chips20 .* CIED65)'; % Eq 7, 20 RGB triplets
d2 = Ad2' * (chips20 .* CIED65)';
% subplot(1,2,1);
% showRGB(d);
% subplot(1,2,2);
% showRGB(d2);

% 1.2) As predicted, they are similar but not equal.
% Ad captures a larger range of wavelengths in [550, 700] and greater magnitude than Ad2
% which results in a brighter red channel. The same thing happens for Ad2
% with the green channel, although with an even larger difference.

%%
eWhite = ones(1,61);
dNorm1 = Ad' * eWhite';
dNorm2 = Ad2' * eWhite';

% 2.1) Unclear

% showRGB(RGB_RAW_D65.*dNorm1)
% showRGB(d2.*dNorm2)

% 2.2) The red channels are very similar in color. The blue and green
% channels are somewhat similar and vice versa.

% plot(wavelengths, CIED65)
% figure;
% plot(wavelengths, CIEA)

% 2.3) Outdoors light contain a lot more blue and green light while indoors
% light contain more red (warmth)

load RGB_CAL_D65;
load RGB_raw_D65;
dCIEA = Ad' * (chips20 .* CIEA)'; % Eq 7, 20 RGB triplets
% showRGB(dCIEA);

% 2.4) CIEA gives a larger response in the red channel as expected while
% DC65 gives a larger response in the green and blue channels

DwhiteDC = Ad' * (eWhite .* CIED65)';
DwhiteA = Ad' * (eWhite .* CIEA)';

showRGB(RGB_RAW_D65 .* DwhiteDC);
showRGB(RGB_RAW_D65 .* DwhiteA);

% 2.5) Normalized CIEA doesn't appear to capture a lot of light at all
% Normalized DC65 captures a lot of blue and a moderate amount of green

%%





















