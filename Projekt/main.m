%% Main

%Load file and adjust if neccessary
im = imread('test_images\example_image.jpg');
im = adjustInput(im);

%Calculate mean L,A,B values for each cell (32x16) in inputImage
meanImVec = extractCellColors(im); %I can't be sure how 
                                   %right or wrong the calculations are, 
                                   %hard to say. But size of vec seems off!
                                  
%Compare mean values for cells to flags

%Construct reproduction using flags

%Use Snr, S-CIELAB to valdiate resemblense to orginal image

