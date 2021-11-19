% *****************************************
% PROGRAM CREATE MASK AND IMAGE GRAY FOR FLOWER USE KNN
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% NOTE:
% - numbers folder in data == number class initialize
% *****************************************

% STRUCT FOLDER IMAGE
% .../data/
%          - daisy/
%                 - image1.tif (.jpg, ...)
%                 - image2.tif (.jpg, ...)
%                   ....
%          - rose/
%                 - image1.tif (.jpg, ...)
%                 - image2.tif (.jpg, ...)
%                   ....
%           .....
clc
clear
% path data
path_data = 'D:\ky_thuat_nhan_dang\datasets_seg\';
% initialization class
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
for k = 1:length(class)
    % create path folder class
    path = strcat(path_data, char(class(k)), '\');
    % get all name file of folder image current
    list_file = dir([path, '*.jpg']);
    for i=1:length(list_file)
        % create path image of folder image current
        path_image = [path, list_file(i).name];
        % read image
        im_org = imread(path_image);
        % filter gauss
        G = fspecial('gaussian',[3 3],2);
        Ig = imfilter(im_org,G,'same');
        %gray = rgb2gray(Ig);
        %gray = imadjust(gray, [0.3,0.7],[]);
        % extract flower use knn
        image = flower_extract(Ig, 2, 1);
        for j=1:length(image)
            img = image{j};
            if length(size(img)) > 2
                % create path save mask and gray
                path_save_gray = strcat(path_data,'dataset_gray\',char(class(k)), 'aa-', string(j), list_file(i).name);
                path_save_mask = strcat(path_data,'dataset_segment\',char(class(k)), 'aa-\',string(j) ,list_file(i).name);
                % convert image extract -> gray
                img = rgb2gray(img);
                imwrite(img, char(path_save_gray))
                % convert image extract -> mask
                img(img > 0) = 255;
                imwrite(img, char(path_save_mask))
            end
        end
    end
end



