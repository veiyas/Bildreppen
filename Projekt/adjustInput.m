%%

testImage = imread('example_image.jpg'); %The input
% imshow(testImage);

% 
% lowerThreshold;
% UpperThreshold;

height = size(testImage, 1); 
width = size(testImage, 2); 

inputImRatio = width/height; 

flagW = 32;
flagH = 16;

widthDivisions = width/flagW;
heightDivisions = height/flagH;

    if isinteger(widthDivisions) | isinteger(heightDivisions)
         disp('The image size is ok!');
    end
     if isinteger(widthDivisions)
         disp('The image has to be adjusted vertically');
     end
     if isinteger(heightDivisions) 
         disp('The image has to be adjusted horizontally');
    end

    disp('The image have to be adjusted for both!');
    %Remove parts of image, up to a maximum of 31 pixels in row/column




