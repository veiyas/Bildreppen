function [optimisedDatabase, optimisedMeanColors] = optimiseColors(flagDatabase, meanLabDatabase, tolerance)
% identify uneccessary flags that share similar colors
    % n^2 time  complexity :s
optimisedIndices = [];
optimisedFlagIter = 1;

for i = 1:3:size(meanLabDatabase,2)
    currentMean = meanLabDatabase(:, i:i+2);
    
    for j = i:3:size(meanLabDatabase,2)
        allOther = meanLabDatabase(:, j:j+2);
        if(allOther == currentMean)
            continue;
        end
        
        colorDiffLAB = sqrt(sum((currentMean-allOther).^2));
        
        if(colorDiffLAB > tolerance)
            optimisedIndices(optimisedFlagIter) = j;
            optimisedFlagIter = optimisedFlagIter + 1;
        end
    end
end

optimisedIndices = unique(optimisedIndices);
optimisedDatabase = zeros(8,16,1);
optimisedMeanColors = zeros(3,1);
optimisedFlagIter = 1;
optimisedMeanIter = 1;

for i = 1:size(optimisedIndices,2)
   optimisedDatabase(:,:,optimisedFlagIter:optimisedFlagIter+2) = flagDatabase(:,:,optimisedIndices(i):optimisedIndices(i)+2);
   optimisedMeanColors(:, optimisedMeanIter) = meanLabDatabase(:, i:i+2);
   optimisedFlagIter = optimisedFlagIter + 3;
   optimisedMeanIter = optimisedMeanIter + 1;
end

disp('Saving database...');
save('flagDatabase.mat', 'flagDatabase');

disp('All done!');
end

