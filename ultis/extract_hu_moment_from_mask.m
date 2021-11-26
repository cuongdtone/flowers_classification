clc;
clear all;
addpath(genpath('.\ultis'));
addpath(genpath('.\models'));
addpath(genpath('.\hu'));

% This module: extract Hu moment matrix and save file mat from
% datasets_binary_mask
% Structure: Same origin dataset but format of image is .tif (binary image)
% Dev: Cuong Tran, Thien Le Van, Duy Ngu Dao

path_datasets_binary_mask = 'datasets_seg\'

name_class = {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'};
datasets = [];

format long;
for i = 1:5
    dataset_path = [path_datasets_binary_mask, char(name_class(i))]    
    files = dir([dataset_path, '\*.tif']);
    list_S = [];
    list_label = []
    for j = 1:length(files)
        image = imread([dataset_path, '\',files(j).name]);
        image = image(:,:,1);
        image = logical(image);
	
        S = hu_moment_2(image);

        label = i;
        data = [label, S]
        datasets(end+1, :) = data;
    end
end
save hu_4 datasets


