clc;
clear all;

name_class = 'lotus'
dataset_path = ['datasets\', name_class]

dataset_seg_path = ['datasets_seg\', name_class]
mkdir(dataset_seg_path)

files = dir([dataset_path, '\*.jpg']);
for i = 1:length(files)
    image = imread([dataset_path, '\',files(i).name]);
    image = segment_color(image, 2);
    name_img = strsplit(files(i).name, '.');
    name_img = name_img(1:length(name_img)-1);
    imwrite(image, [dataset_seg_path, '\', char(name_img), '.tif'])
end