function [repIm] = reproduceWithSCIELabFlagsSmall(meanCellColors, flagDatabase, meanXYZDatabase)

whitePoint = [95.05, 100, 108.9];
PPI = 91.79;
d = 19.685;
SPD = PPI * d * tan(pi / 180);

for i = 1:size(meanCellColors, 1)
    currentCellIndices = meanCellColors(i, 1:2);
    currentCellMean = meanCellColors(i, 3:5);
    
    % Search for lowest diff
    lowestDiff = 1000000000;
    lowestDiffIndex = -1;
    for j = 1:3:size(meanXYZDatabase, 2)
        res = scielab(SPD, currentCellMean, [meanXYZDatabase(1,j) meanXYZDatabase(1,j+1) meanXYZDatabase(1,j+2)], whitePoint, 'xyz');
        meanSCIELabDiff = mean(res(:));
        
        if meanSCIELabDiff < lowestDiff
            lowestDiff = meanSCIELabDiff;
            lowestDiffIndex = j;
        end
    end
    
    % Get cell coordinates in image
    cellRow = (currentCellIndices(1) - 1)*8 + 1;
    cellCol = (currentCellIndices(2) - 1)*16 + 1;

    repIm(cellRow:cellRow+7, cellCol:cellCol+15, :) = flagDatabase(:,:,lowestDiffIndex:lowestDiffIndex+2);
end
end

