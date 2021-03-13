function [repIm] = reproduceWithOptimisedFlags(meanCellColors)
load optiFlagDatabase.mat optiFlagDatabase; load OptiMeanLabDatabase.mat OptiMeanLabDatabase;

% currently making the optiDatabase into a row vector as it only accepts
% those
OptiMeanLabDatabase = OptiMeanLabDatabase(:)';

for i = 1:size(meanCellColors, 1)
    currentCellIndices = meanCellColors(i, 1:2);
    currentCellMean = meanCellColors(i, 3:5);
    
    % Search for lowest diff
    lowestDiff = 1000000000;
    lowestDiffIndex = -1;
    for j = 1:3:size(OptiMeanLabDatabase, 2)
        colorDiffLAB = sqrt(sum((currentCellMean - [OptiMeanLabDatabase(1,j) OptiMeanLabDatabase(1,j+1) OptiMeanLabDatabase(1,j+2)]).^2));
        
        if colorDiffLAB < lowestDiff
            lowestDiff = colorDiffLAB;
            lowestDiffIndex = j;
        end
    end
    
    % Get cell coordinates in image
    cellRow = (currentCellIndices(1) - 1)*8 + 1;
    cellCol = (currentCellIndices(2) - 1)*16 + 1;

    repIm(cellRow:cellRow+7, cellCol:cellCol+15, :) = optiFlagDatabase(:,:,lowestDiffIndex:lowestDiffIndex+2);
end
end

