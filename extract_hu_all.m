clc
clear
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
path_data = 'D:\ky_thuat_nhan_dang\datasets_seg\'
for k = 1:length(class)
    path = strcat(path_data, char(class(k)), '\'); %folder image
    path_save = strcat(path_data, char(class{k}),'.mat');
    % get all path image
    list_file = dir([path, '*.tif']);
    data = zeros(1,7);
    labels = zeros(1,5);
    index_object = 1;
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
        array_hu(array_hu == 0) = 1;
        data(i, :) = sign(array_hu).*abs(log10(abs(array_hu)));
        labels(i, index_object) = 1;
    end
    % save data and labels
    save(path_save, 'data', 'labels')
end