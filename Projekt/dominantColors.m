%%  Find the color componednts buidling up a flag
% https://www.researchgate.net/publication/5602033_Extraction_of_perceptually_important_colors_and_similarity_measurement_for_image_matching_retrieval_and_analysis

imshow(flagDatabase(1:8, 1:16, 1:3))
meanDatabase(1, 1:3) %LAB values for flag nr 1

%Using k-mean to identify different colors
ab = lab_he(:,:,2:3);
ab = im2single(ab);
nColors = 3;
% repeat the clustering 3 times to avoid local minima
pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',3);
