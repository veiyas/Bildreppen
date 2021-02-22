function R=snr_filter(X,Y)

%   R = SNR(X, Y) computes the signal to noise ratio (SNR) in dB.
%   The signal X and the noise Y are first filtered by a filter
%   representing the eye.

f=MFTsp(15,0.0847,500);
% Denna funktion returnerar ett l�gpass filter som representerar �gat. I
% detta fall betraktningsavst�ndet har satts till 500 mm och punkternas
% storlek till 0.0847. Observera att punktens storlek motsvarar ett tryck
% i 300 dpi. (0.0847 = 1/300 * 25.4 mm)


s=conv2(X,f,'same');
% �gats filter �r applicerat till signalen (originalbilden)

n=conv2(Y,f,'same');
% �gats filter �r applicerat till "noise"-en (skillnaden mellan originalbilden och rasterbilden)


R=snr(s,n);
% Man r�knar snr mellan signalen och noise-en efter att de har g�tt genom
% �gats filter
