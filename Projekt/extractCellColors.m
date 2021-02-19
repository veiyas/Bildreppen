function [outVector] = extractCellColors(inputImage)

imWidth = size(inputImage, 2);
imHeight = size(inputImage, 1);
flagW = 32;
flagH = 16;

vectorIndex = 1; %temp solution to iterate through storage vector

nCells = (imHeight/flagH)*(imWidth/flagW);

meanCellColorVec = zeros(1,nCells);  %Scuffed egentligen

for h = 1:flagH:imHeight-16 %Go through image vertically
 
    for w = 1:flagW:imWidth-32 %Go through image horizontally
       
        %Extract rgb values for each cell
        rgbCell = inputImage(h: h+flagH - 1,w: w+flagW - 1 ,1:3);
        
        %Convert rgb to LAB
        labCell = rgb2lab(rgbCell);
        
        %Calculate cell mean color in LAB
        meanCellColor = mean(mean(labCell));
        
        %Store each cell in L.A.B format for comparison with meanFlag
        meanCellColorVec(:,vectorIndex) = meanCellColor(:,:,1);
        meanCellColorVec(:, vectorIndex+1) = meanCellColor(:,:,2);
        meanCellColorVec(:,vectorIndex+2) = meanCellColor(:,:,3);
        
        vectorIndex = vectorIndex + 3;
        

    end
    
end

disp('Saing vector with mean cell colors!');
save('meanCellColorVec.mat', 'meanCellColorVec');
disp('Done!');

outVector = meanCellColorVec; %easier of debug, not necassary

end

