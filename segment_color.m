function segmented_images = segment_color(image, nColors );
cform = makecform('srgb2lab');
lab_he = applycform(image, cform);
 
ab = double(lab_he(:,:,2:3));
nrows = size(ab, 1);
ncols = size(ab, 2);

ab = reshape(ab, nrows*ncols, 2);

[cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqEuclidean', ...
    'Replicates', 3);

pixel_labels = reshape(cluster_idx, nrows, ncols);
%figure
%imshow(pixel_labels, [])

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels, [1 1 3]);
for k = 1:nColors
    color = image;
    color(rgb_label ~=k) = 0;
    segmented_images{k} = color;
end