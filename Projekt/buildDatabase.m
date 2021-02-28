%% Load all country id's
disp('Parsing country IDs...');
fileID = fopen('flags\originals\ids.txt', 'r');
countryIds = fscanf(fileID, '%s');

disp('Constructing database...');
prefixPath = 'flags/originals/PNG-32/';
postfixPath = '-32.png';
nCountries = size(countryIds, 2) / 2;
 
flagDatabase = zeros(16,32, nCountries*3);
databaseIterator = 1;
for i = 1:2:size(countryIds,2)
    fullPath = strcat(prefixPath, countryIds(:, i:i+1), postfixPath);    
    img = imread(fullPath);

    % We standardize flags to 32x16 by filling out if necessary
    if size(img,3) ~= 3 % If MATLAB couldn't find RGB channels directly
    [im, map, alpha] = imread(fullPath);
    rgbIm = ind2rgb(im, map); % Reconstruct RGB image from indice map

        if sum(sum(alpha==0) > 0) > 0 % Fill out transparent regions from the left
            [~, col] = find(~alpha, 1); % First instance of transparency
            nColsToFill = size(rgbIm(:, col:end,:), 2);
            rgbIm(:, col-1:end,:) = repmat(rgbIm(:, col-2, :), 1, nColsToFill+1); % Fill out horizontally with some margins
        end
    else
        rgbIm = img;
        [~, ~, alpha] = imread(fullPath);

        if sum(sum(alpha==0) > 0) > 0 % Fill out transparent regions from the left
            [~, col] = find(~alpha, 1); % First instance of transparency
            nColsToFill = size(rgbIm(:, col:end,:), 2);
            rgbIm(:, col-1:end,:) = repmat(rgbIm(:, col-2, :), 1, nColsToFill+1); % Fill out horizontally with some margins
        end
    end
    
    flagDatabase(:,:,databaseIterator:databaseIterator+2) = im2double(rgbIm);
    databaseIterator = databaseIterator + 3;
end
disp('Saving database...');
save('flagDatabase.mat', 'flagDatabase');

disp('All done!');