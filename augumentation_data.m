% *****************************************
% PROGRAM AUGUMENTATIONS
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
% set path folder data
path_data = 'D:\ky_thuat_nhan_dang\datasets_seg\dataset_segment\';
% initialization class
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
fprintf('Processing...\n')
for k = 1:length(class)
    % create path folder class
    path = strcat(path_data, char(class(k)), '\');
    % get path file image of folder class current
    list_file = dir([path, '*.jpg']);
    for i=1:length(list_file)
        % create path image
        path_image = [path, list_file(i).name];
        % read image
        im_org = imread(path_image);
        count = 1;
        % rotate image
        for goc=45:45:359
            if 90 < goc && goc < 270
                continue
            end
            % create path save
            path_save_gray = strcat(path_data, char(class(k)), '\a_', string(count),list_file(i).name);
            % rotate image a angle goc
            im_rotate = imrotate(im_org, goc);
            % save image after rotate
            imwrite(im_rotate, char(path_save_gray))
            count = count + 1;
        end
        % flip image
        % create path save
        path_save_gray = strcat(path_data, char(class(k)), '\a_', string(count),list_file(i).name);
        % flip left right image
        im_lr = fliplr(im_org);
        imwrite(im_lr, char(path_save_gray))
        count = count + 1;
        %path_save_gray = strcat(path_data, char(class(k)), '\a_', string(count),list_file(i).name);
        % flip up down image
        %im_ud = flipud(im_org);
        %imwrite(im_ud, char(path_save_gray))
    end
end
fprintf('Finish.\n')