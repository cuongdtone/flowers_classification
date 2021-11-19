% *****************************************
% PROGRAM EXTRACT FEATURE HOG FOR IMAGE OF ALL CLASS
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% NOTE:
% - image processing is image gray and change format file image (.tif,
% .jpg, ...) at row 42
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
% ALL FUNCTION USE: hog_feature(), extract_hog()
% clear
clc
clear
% initialization number class
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
% set path data
path_data = 'D:\ky_thuat_nhan_dang\datasets_seg\'
% set path save
path_save_train = strcat(path_data, 'datasets_hog_train.xlsx');
path_save_test = strcat(path_data, 'datasets_hog_test.xlsx');
% initialization size of window and stride
size_window = 16;
stride = 8;
% compute number features
number_feature = ((64-size_window)/stride + 1)*((128-size_window)/stride + 1)*36;
% initialization matrix include index labels and features
train = zeros(1, number_feature + 1);
test = zeros(1, number_feature + 1);
count_train = 1;
count_test = 1;
thresh = 0.8;
for k = 1:length(class)
    % create path folder image of class current
    path = strcat(path_data, char(class(k)), '\'); %folder image
    % get all path image of class current
    list_file = dir([path, '*.tif']);
    % processing image of classs current
    fprintf('--FOLDER %d--\n', k)
    for i=1:length(list_file)
        fprintf('processing... %d\n', round(i*100/length(list_file)))
        % create path image current of class
        path_image = [path, list_file(i).name];
        % read image
        im_org = imread(path_image);
        % extract hog
        feature_hog = extract_hog(im_org, size_window, stride);
        % assign label of class is value k
        if i <= round(length(list_file)*thresh)
            train(count_train, 1) = k;
            % assign vector feature of image current
            train(count_train, 2:number_feature+1) = feature_hog;
            count_train = count_train + 1;
        else
            test(count_test, 1) = k;
            % assign vector feature of image current
            test(count_test, 2:number_feature+1) = feature_hog;
            count_test = count_test + 1;
        end
    end
end
fprintf('FINISH!\n')
T_train = table(train);
T_test = table(test);
% save data
writetable(T_train, path_save_train)
writetable(T_test, path_save_test)