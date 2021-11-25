function out = segment_color(image, nColors );
% Segmentation color wiht Kmean method
cform = makecform('srgb2lab');
lab_he = applycform(image, cform);
 
ab = double(lab_he(:,:,2:3));
nrows = size(ab, 1);
ncols = size(ab, 2);

ab = reshape(ab, nrows*ncols, 2);

[cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqEuclidean', ...
    'Replicates', 3);

pixel_labels = reshape(cluster_idx, nrows, ncols)-1;
out = pixel_labels;
revert_signal = sum(out(2,:));
if revert_signal>ncols/2
    out(pixel_labels==0) = 1;
    out(pixel_labels==1) = 0;
end

    




