clc;
clear all;

name_class = {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'};

datasets = [];

for i = 1:5
    dataset_path = ['Test\', char(name_class(i))]

    files = dir([dataset_path, '\*.tif']);
    list_S = [];
    list_label = []
    for j = 1:length(files)
        image = imread([dataset_path, '\',files(j).name]);
        image = image./255;
        

        S = hu_moment(image);
        label = i;
        
        data = [label, S(1), S(2), S(3), S(4), S(5), S(6), S(7)]
        datasets(end+1, :) = data;
    end
end
save test datasets


