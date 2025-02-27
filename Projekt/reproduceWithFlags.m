function [repIm] = reproduceWithFlags(meanCellColors)
load flagDatabase.mat flagDatabase; load meanDatabase.mat meanDatabase; % This is probably very slow
whitePoint = [95.05, 100, 108.9];
PPI = 91.79;
d = 19.685;
SPD = PPI * d * tan(pi / 180);

repIm = zeros(meanCellColors(end,1)*16, meanCellColors(end,2)*32, 3);

for i = 1:size(meanCellColors, 1)
    currentCellIndices = meanCellColors(i, 1:2);
    currentCellMean = meanCellColors(i, 3:5);
    
    % Search for lowest diff
    lowestDiff = 1000000000;
    lowestDiffIndex = -1;
    for j = 1:3:size(meanDatabase, 2)
        colorDiffLAB = sqrt(sum((currentCellMean - [meanDatabase(1,j) meanDatabase(1,j+1) meanDatabase(1,j+2)]).^2));
%         res = scielab(SPD, currentCellMean, [meanDatabase(1,j) meanDatabase(1,j+1) meanDatabase(1,j+2)], whitePoint, 'xyz');
%         meanSCIELabDiff = mean(res(:));
        
        if colorDiffLAB < lowestDiff
            lowestDiff = colorDiffLAB;
            lowestDiffIndex = j;
        end
    end
    
    % Get cell coordinates in image
    cellRow = (currentCellIndices(1) - 1)*16 + 1;
    cellCol = (currentCellIndices(2) - 1)*32 + 1;

    repIm(cellRow:cellRow+15, cellCol:cellCol+31, :) = flagDatabase(:,:,lowestDiffIndex:lowestDiffIndex+2);
end
end

