function [repIm] = reproduceWithLabFlagsSmall(meanCellColors, flagDatabase, meanLabDatabase)

for i = 1:size(meanCellColors, 1)
    currentCellIndices = meanCellColors(i, 1:2);
    currentCellMean = meanCellColors(i, 3:5);
    
    % Search for lowest diff
    lowestDiff = 1000000000;
    lowestDiffIndex = -1;
    for j = 1:3:size(meanLabDatabase, 2)
        colorDiffLAB = sqrt(sum((currentCellMean - [meanLabDatabase(1,j) meanLabDatabase(1,j+1) meanLabDatabase(1,j+2)]).^2));
        
        if colorDiffLAB < lowestDiff
            lowestDiff = colorDiffLAB;
            lowestDiffIndex = j;
        end
    end
    
    % Get cell coordinates in image
    cellRow = (currentCellIndices(1) - 1)*8 + 1;
    cellCol = (currentCellIndices(2) - 1)*16 + 1;

    repIm(cellRow:cellRow+7, cellCol:cellCol+15, :) = flagDatabase(:,:,lowestDiffIndex:lowestDiffIndex+2);
end
end

