clc
clear
path = 'D:\ky_thuat_nhan_dang\datasets_seg\daisy\'; %folder image
path_save = 'D:\ky_thuat_nhan_dang\datasets_seg\daisy_hu_moments.mat';
% get all path image
list_file = dir([path, '*.tif']);
data = zeros(1,8);
labels = zeros(1,5);
for i=1:length(list_file)
    fprintf('processing... %d\n', round(i*100/length(list_file)))
    % create path image
    path_image = [path, list_file(i).name];
    % read image
    im_org = imread(path_image);
    % check size
    size_im = size(im_org);
    if length(size_im) > 2
        im_org = rgb2gray(im_org);
        imwrite(im_org, path_image);
    end
    % normal image about range 0->1
    image = im_org/255;
    % extract hu_moment
    array_hu = hu_moment(image);
    data(i, 1) = i;
    data(i, 2:8) = array_hu;
    labels(i, 2) = 1;
end
% save data and labels
save(path_save, 'data', 'labels')