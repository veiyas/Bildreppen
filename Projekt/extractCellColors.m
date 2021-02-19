function [extractedCell] = extractCellColors(inputImage)
%WIP
imWidth = size(inputImage, 2);
imHeight = size(inputImage, 1);
flagW = 32;
flagH = 16;

%meanCellColorVec = zeros(1, n_flagsX3);

for h = 1:flagH:imHeight-16 %Go through image vertically
   
    for w = 1:flagW:imWidth-32 %Go through image horizontally
      
        %Extract rgb values for each cell
        rgbCell = im2double(inputImage(h:h+flagH-1,w:w+flagW-1,1:3));
        %Convert rgb to LAB
        labCell = rgb2lab(rgbCell);
        %Calculate cell mean color in LAB
        meanCellColor = mean(mean(labCell));
        %Store each cell in L.A.B format for comparison with meanFlag
        
       
    end
    
end




extractedCell = labCell;

end

