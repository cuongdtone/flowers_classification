function output = flower_extract(im_org, ncolor, brightness);
im_tang = uint8(((double(im_org)/255).^brightness)*255);
im_org = im_tang;
cform = makecform('srgb2lab'); % tao cau truc chuyen doi kenh mau rgb sang lab
lab = applycform(im_org, cform); % thuc hien chuyen doi kenh mau theo cau trau cform
ab = double(lab(:,:,2:3)); % lay 2 kenh mau a va b
nrows = size(ab,1); % lay kich thuoc hang
ncols = size(ab,2); % lay kich thuoc cot
ab = reshape(ab, nrows*ncols, 2); % bien doi ma tran ab thanh nrows*ncols hang va 2 cot
K = ncolor; % khoi tao 3 cluster
[cluster_idx, cluster_center] = kmeans(ab, K, 'distance', 'sqEuclidean', ...
    'Replicates', 3); % thuat toan kmeans phan loai cac diem pixel trong ab thanh 3 cum su dung kc Euclidean và moi phan cum lap lai 3 lan
pixel_labels = reshape(cluster_idx, nrows, ncols); % chuyen doi cac diem cluster_idx ma tran nrows hang va ncols cot
%imshow(pixel_labels, [])
segmented_images = cell(1,3); % tao mot mang size 1x3 chua cac empty matrix 
rgb_label = repmat(pixel_labels, [1 1 3]); % tao ma tran 3 chieu co size nrowsxncolsx3
for k=1:K % duyet tung cum
    color = im_org; % copy anh goc
    color(rgb_label ~= k) = 0; % gan nhung diem pixel co cluster khac k hien tai thanh 0
    %color(rgb_label == k) = 255;
    segmented_images{k} = color; % gan ma tran color sau khi xu ly vao mang seg
end
output = segmented_images;
