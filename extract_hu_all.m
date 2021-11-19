% *****************************************
% PROGRAM EXTRACT FEATURE HU MOMENT FOR IMAGE OF ALL CLASS
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% NOTE:
% - image processing is image gray and change format file image (.tif,
% .jpg, ...) at row 33
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
% ALL FUNCTION USE: hu_moment()
% clear
clc
clear
% initialization class name
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
% set path data
path_data = 'D:\ky_thuat_nhan_dang\datasets_seg\';
% set path save
path_save_train = strcat(path_data,'datasets_hu_train.xlsx');
path_save_test = strcat(path_data,'datasets_hu_test.xlsx');
% initialization matrix 
train = zeros(1,8);
test = zeros(1,8);
count_train = 1;
count_test = 1;
% create thresh
thresh = 0.8;
for k = 1:length(class)
    % create path folder class
    path = strcat(path_data, char(class(k)), '\');
    % get all path image of folder class current
    list_file = dir([path, '*.tif']);
    fprintf('--FOLDER %d--\n', k)
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
        if i <= round(thresh*length(list_file))
            train(count_train, 1) = k;
            train(count_train, 2:8) = log10(abs(array_hu));
            count_train = count_train + 1;
        else
            test(count_test, 1) = k;
            test(count_test, 2:8) = log10(abs(array_hu));
            count_test = count_test + 1;
        end
    end
end
fprintf('FINISH!\n')
% convert matrix -> table
T_train = table(train);
T_test = table(test);
% save data
writetable(T_train, path_save_train)
writetable(T_test, path_save_test)