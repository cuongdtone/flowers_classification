clc
clear
path = 'D:\ky_thuat_nhan_dang\'; %folder image
% get all path image
list_file = dir([path, '*.jpeg']);
for i=1:length(list_file)
    % create path image
    path_image = [path, list_file(i).name];
    % read image
    im_org = imread(path_image);
    % normal image about range 0->1
    image = im_org/255;
    % extract hu_moment
    array_hu = hu_moment(image)
end