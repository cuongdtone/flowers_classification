clc
clear
path = 'D:\ky_thuat_nhan_dang\';
name_flower = 'lyli';
mkdir([path, 'datasets']);
mkdir([path, 'datasets\', name_flower])
list_file = dir([path, '*.jpeg']);
for i=1:length(list_file)
    path_image = [path, list_file(i).name];
    im_org = imread(path_image);
    G = fspecial('gaussian',[3 3],2);
    Ig = imfilter(im_org,G,'same');
    %gray = rgb2gray(Ig);
    %gray = imadjust(gray, [0.3,0.7],[]);
    image = flower_extract(Ig, 3, 1);
    for j=1:length(image)
        path_save = [path, 'datasets\', name_flower, '\',int2str(j),'-', list_file(i).name];
        imwrite(image{j}, path_save)
    end
end
