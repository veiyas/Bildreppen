%%  Find the color componednts buidling up a flag
% https://www.researchgate.net/publication/5602033_Extraction_of_perceptually_important_colors_and_similarity_measurement_for_image_matching_retrieval_and_analysis
% A Problem that all kmeans clustering methods seem to have is that we have
% to know beforehand how many major color parts each flag consists off,
% seems kind off excessive for us to make that possible for all 219 flags?

rgbFlag = flagDatabase(1:8, 1:16, 1:3);
imshow(rgbFlag);
flagLAB = meanDatabase(1, 1:3); %LAB values for flag nr 1

%Using k-mean to identify different colors
ab = flagLAB(2:3); %Color is only existant in a,b
ab = im2single(ab);
nColors = 3;

pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',10); %This fails often!

imshow(pixel_labels,[])
title('Image Labeled by each cluster index');

%Show indivudal cluster channel (Currently not compatible)

mask1 = pixel_labels == 1;
cluster1 = rgbFlag .* uint8(mask1);
imshow(cluster1)
title('Cluster 1');

mask2 = pixel_labels == 2;
cluster2 = rgbFlag .* uint8(mask2);
imshow(cluster2)
title(' Cluster 2');

mask3 = pixel_labels == 3;
cluster3 = rgbFlag .* uint8(mask3);
imshow(cluster3)
title('Cluster 3');
