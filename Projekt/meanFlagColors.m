%%
load flagDatabase.mat;
disp('Calculating mean LAB values for each flag...');

n_flagsX3 = size(flagDatabase, 3);

meanDatabase = zeros(1, n_flagsX3); %Vector with mean LAB values for each flag
                                    %Scuffed egentligen, borde hitta bättre
                                    %lösning

for i = 1:3:size(flagDatabase, 3)    
    rgbFlag = (flagDatabase(:,:,i:i+2)); % gets rgb values
    
    labFlag = rgb2lab(rgbFlag); %converts rgb to lab
    
    meanColor = mean(mean(labFlag)); %Gives the mean for L, a and b separate
    
    meanDatabase(:,i) = meanColor(:,:,1);
    meanDatabase(:,i+1) = meanColor(:,:,2);
    meanDatabase(:,i+2) = meanColor(:,:,3); %Store them in a 654 long vector
    %where each 3 pairs are for an individual flag.    
end

disp('Mean calcuations, saving database...!');
save('meanDatabase.mat', 'meanDatabase');
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
 
