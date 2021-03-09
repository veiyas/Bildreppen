load meanLabDatabase.mat;
allColors = zeros(size(meanLabDatabase,2)/3, 3);
allColorsIter = 1;

for i = 1:3:size(meanLabDatabase, 2)
    allColors(allColorsIter,:) = [meanLabDatabase(1,i) meanLabDatabase(1,i+1) meanLabDatabase(1,i+2)];
    allColorsIter = allColorsIter + 1;
end
allColors = allColors';

labFig = plot_Lab(4, allColors, 1, 'r', 70, -1);