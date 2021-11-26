clc
clear all

% Crop image with Binary Mask

path_binary_mask = 'datasets_seg\'
path_origin_datasets = 'datasets\'

save_path = 'datasets_gray_object\';
mkdir(save_path);

name_class = {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'};
for i=1:5
    dataset_origin_path = [path_origin_datasets, char(name_class(i))]
    dataset_binary_mask = [path_binary_mask, char(name_class(i))]
    
    dataset_gray_path = [save_path, char(name_class(i))];
    mkdir(dataset_gray_path)

    files = dir([dataset_binary_mask, '\*.tif']);
    length(files)
    for i = 1:length(files)
        mask = imread([dataset_binary_mask, '\',files(i).name]);
        name_img = strsplit(files(i).name, '.');
        name_img = name_img(:, 1)
 
        image = imread([dataset_origin_path, '\',char(name_img), '.jpg']);
        image = rgb2gray(image);
        
        mask = logical(mask);
        mask = mask(:,:,1);
        
        image(mask==0) = 0;

        imwrite(image, [dataset_gray_path, '\', char(name_img), '.jpg'])
    end
end

