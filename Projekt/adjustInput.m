function [adjusted] = adjustInput(image)

height = size(image, 1);
width = size(image, 2);

flagW = 32;
flagH = 16;

minWidth = 1000;
minHeight = 500;
maxWidth = 2500;
maxHeight = 2000;

% Check image size
if width < minWidth || height < minHeight
   disp('Image too small, enlarging bicubically. This will produce artifacts.');
   image = imresize(image, [NaN 1920], 'bicubic');
end

if width > maxWidth || height > maxHeight
   disp('Image too large, shrinking bicubically. This will produce artifacts.');
   image = imresize(image, [NaN 1920], 'bicubic');
end


% Adjust image to fit flag proportions
if rem(width, flagW) ~= 0
    cutoffMargin = rem(width, flagW);
    image(:, end-cutoffMargin+1:end, :) = [];
    disp('Image adjusted horizontally.');
end
if rem(height, flagH) ~= 0
    cutoffMargin = rem(height, flagH);
    image(end-cutoffMargin+1:end, :, :) = [];
    disp('Image adjusted vertically.');
end
adjusted = image;
end