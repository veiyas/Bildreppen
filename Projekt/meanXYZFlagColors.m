%%
load flagDatabase.mat;
disp('Calculating mean XYZ values for each flag...');

n_flagsX3 = size(flagDatabase, 3);

meanXYZDatabase = zeros(1, n_flagsX3);

for i = 1:3:size(flagDatabase, 3)    
    rgbFlag = (flagDatabase(:,:,i:i+2)); % gets rgb values
    
    xyzFlag = rgb2xyz(rgbFlag); %converts rgb to lab
    
    meanColor = mean(mean(xyzFlag)); %Gives the mean for L, a and b separate
    
    meanXYZDatabase(:,i) = meanColor(:,:,1);
    meanXYZDatabase(:,i+1) = meanColor(:,:,2);
    meanXYZDatabase(:,i+2) = meanColor(:,:,3); %Store them in a 654 long vector
    %where each 3 pairs are for an individual flag.    
end

disp('Mean calcuations, saving database...!');
save('meanXYZDatabase.mat', 'meanXYZDatabase');
disp('All done!');

%Old junk below

% flag = (flagDatabase(:,:,1:3)); %rgb flag 
% 
% labFlag_v2 = rgb2lab(flag);
% 
% meanColor =  mean(mean(labFlag_v2));
% meanL = meanColor(:,:,1);
% meanA = meanColor(:,:,2);
% meanB = meanColor(:,:,3);

% imshow(flag)
% imshow(xyzFlag)
% imshow(labFlag)

% xyzFlag = rgb2xyz(flag); 
% 
% labFlag = xyz2lab(xyzFlag(:,:,1), xyzFlag(:,:,2), xyzFlag(:,:,3));
%  
% meanColor = mean(labFlag); %full conversion
 
