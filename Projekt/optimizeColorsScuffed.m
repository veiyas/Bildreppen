function [optimizedDatabase] = optimizeColorsScuffed(meanLabDatabase)
% identify uneccessary flags that share similar colors
    % n^2 time  complexity :s
    
allColors = zeros(size(meanLabDatabase,2)/3, 3);
allColorsIter = 1;

for i = 1:3:size(meanLabDatabase, 2)
    allColors(allColorsIter,:) = [meanLabDatabase(1,i) meanLabDatabase(1,i+1) meanLabDatabase(1,i+2)];
    allColorsIter = allColorsIter + 1;
end
allColors = allColors';

    flagNR = 0; %index for each flag
    indexVectorIt = 1;
    flagsIndexToRemove = []; %used to store which flags can be removed
    
    
    for currentColor = allColors(1:3,:) % go through each flag
       
        similarFlags = 0;
        flagNR = flagNR + 1;
        
        for allOther = allColors(1:3,:) %compare flag i to all other flags
            temp = 0; 
            %making sure it doesnt see itself as uneccesary
            if(allOther == currentColor)
                continue
            end
            %total LAB distance from flag i to another flag
            totalDiff = abs((currentColor(1) - allOther(1)) + (currentColor(2) - allOther(2)) +(currentColor(3) - allOther(3)));
            
            if(totalDiff < 10) % some threshold 
               similarFlags = similarFlags + 1;
               flagsIndexToRemove(indexVectorIt) = flagNR;
               indexVectorIt = indexVectorIt + 1;
            end
            
         
        end
        
    end
    
    
    optimizedDatabase = flagsIndexToRemove; %temp return
end

