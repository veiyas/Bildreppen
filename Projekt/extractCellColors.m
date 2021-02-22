function [outVector] = extractCellColors(inputImage)

imWidth = size(inputImage, 2);
imHeight = size(inputImage, 1);
flagW = 32;
flagH = 16;

nCells = (imHeight/flagH - 16)*(imWidth/flagW - 32);

meanCellVecList = zeros(round(nCells), 5);
meanCellVecIndex = 1;

for h = 1:flagH:imHeight
    for w = 1:flagW:imWidth
        
        rgbCell = inputImage(h: h+flagH - 1, w: w+flagW - 1, 1:3);
        labCell = rgb2lab(rgbCell);
        meanCellColor = mean(mean(labCell));
        
        % A list of all mean L a b values and its cell indices
        % Structure: [heightIndex widthIndex L a b]
        meanCellVecList(meanCellVecIndex, :) = [ceil(h/flagH) ceil(w/flagW) meanCellColor(:,:,1) meanCellColor(:,:,2) meanCellColor(:,:,3)];
        meanCellVecIndex = meanCellVecIndex + 1;        
    end    
end

outVector = meanCellVecList;

end

