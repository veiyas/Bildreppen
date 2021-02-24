function [outVector] = extractCellColorsSmall(inputImage)

imWidth = size(inputImage, 2);
imHeight = size(inputImage, 1);
flagW = 16;
flagH = 8;

nCells = (imHeight/flagH - flagH)*(imWidth/flagW - flagW);

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

