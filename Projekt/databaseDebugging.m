%% Subplot of all flags from files
subplotIterator = 1;
for i = 1:2:500
    subplot(16, 16, subplotIterator);
    
    fullPath = strcat(prefixPath, countryIds(:, i:i+1), postfixPath);
    img = imread(fullPath);

    % We standardize flags to 32x16 by filling out if necessary
    if size(img,3) ~= 3 % If MATLAB couldn't find RGB channels directly
    [im, map, alpha] = imread(fullPath);
    rgbIm = ind2rgb(im, map); % Reconstruct RGB image from indice map

        if sum(sum(alpha==0) > 0) > 0 % Fill out transparent regions from the left
            [~, col] = find(~alpha, 1); % First instance of transparency
            nColsToFill = size(rgbIm(:, col:end,:), 2);
            rgbIm(:, col:end,:) = repmat(rgbIm(:, col-1, :), 1, nColsToFill); % Fill out horizontally
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

    imshow(rgbIm)
    subplotIterator = subplotIterator + 1;
end

%% Subplot of all flags from database
load flagDatabase.mat;

subplotIterator = 1;
for i = 1:3:750
    subplot(16, 16, subplotIterator);
    imshow(flagDatabase(:,:,i:i+2));
    subplotIterator = subplotIterator + 1;
end

%% Debugging database
load flagDatabase.mat;

flagNumber = 249;
index = flagNumber*3+1;

imshow(flagDatabase(:,:,index:index+2))


%% Debugging flag reading and modification
fullPath = 'flags\originals\PNG-32\AG-32.png';

img = imread(fullPath);

% We standardize flags to 32x16 by filling out if necessary
if size(img,3) ~= 3 % If MATLAB couldn't find RGB channels directly
    [im, map, alpha] = imread(fullPath);
    rgbIm = ind2rgb(im, map); % Reconstruct RGB image from indice map

    if sum(sum(alpha==0) > 0) > 0 % Fill out transparent regions from the left
        [~, col] = find(~alpha, 1); % First instance of transparency
        nColsToFill = size(rgbIm(:, col:end,:), 2);
        rgbIm(:, col:end,:) = repmat(rgbIm(:, col-1, :), 1, nColsToFill); % Fill out horizontally
    end
else
    rgbIm = img;
    [im, map, alpha] = imread(fullPath);
    
    if sum(sum(alpha==0) > 0) > 0 % Fill out transparent regions from the left
        [~, col] = find(~alpha, 1); % First instance of transparency
        nColsToFill = size(rgbIm(:, col:end,:), 2);
        rgbIm(:, col-1:end,:) = repmat(rgbIm(:, col-2, :), 1, nColsToFill+1); % Fill out horizontally with some margins
    end
end

imshow(rgbIm)