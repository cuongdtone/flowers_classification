clc;
clear all;

%Set path of origin dataset at line 5
%Structure of datasets:
%       datasets
%               daisy
%                       img1.jpg
%                       image2.jpg
%               lotus
%                       img1.jpg
%                       image2.jpg
%               ...
% You can dowload my datasets at database !
% Binary mask of object will extract and save at save_path (line 8)
% Dev: Cuong Tran, Thien Le Van, Duy Ngu Dao

path = 'datasets\'

save_path = 'datasets_seg_2\';
mkdir(save_path);

name_class = {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'};
for i=1:5
    dataset_path = [path, char(name_class(i))];
    dataset_seg_path = [save_path, char(name_class(i))]
    mkdir(dataset_seg_path)

    files = dir([dataset_path, '\*.jpg']);
    for i = 1:length(files)
        image = imread([dataset_path, '\',files(i).name]);
        image = segment_color(image, 2);
        image = ExtractNLargestBlobs(image, 1);
        %image = imfill(image, 'holes');

        name_img = strsplit(files(i).name, '.');
        name_img = name_img(1:length(name_img)-1);
        imwrite(image, [dataset_seg_path, '\', char(name_img), '.tif'])
    end
end