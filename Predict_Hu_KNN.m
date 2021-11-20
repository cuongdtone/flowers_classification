% *****************************************
% PROGRAM PREDICT IMAGE HU MOMENT USE KNN
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% NOTE:
% - numbers folder in data == number class initialize
% *****************************************
clear
clc
% initialization name class
%*******************AREA CONFIG DATA TRAIN*******************
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
num_class = 5;
K_clus = 1;
% path folder data
path_train = 'D:\ky_thuat_nhan_dang\datasets\dataset_segment\datasets_hu_train.xlsx';
%******************** LOAD PATH IMAGE MASK*************
path_image = 'D:\ky_thuat_nhan_dang\datasets\dataset_segment\Sunflower\';
list_file = dir([path_image, '*.jpg']);
%*******************AREA PROCESSING DATA TRAIN***************
% load dataset
fprintf('Load and processing data ...\n')
train_data = xlsread(path_train);
% size data
[row_train, col_train] = size(train_data);
% div data
train = train_data(:, 2:col_train);
label_train_index = train_data(:, 1);
% print number file train and test
fprintf('Finish processing data...\n')
% processing labels about format 0 0 0 0 1
label_train = zeros(row_train, num_class);
for i=1:row_train
    label_train(i, label_train_index(i, 1)) = 1;
end
%*******************EXTRACT HU MOMENT OF IMAGE PREDICT***************
for i=1:length(list_file)
    image = imread([path_image, list_file(i).name]);
    image = image/255;
    array_hu = hu_moment(image);
    array_hu(array_hu == 0) = 1;
    feature_hu = sign(array_hu).*abs(log10(abs(array_hu)));
    id_predict = KNN(feature_hu, train, label_train, K_clus);
    fprintf('---------------PREDICT--------------\n')
    fprintf('Predict flower: %s\n', string(class(id_predict)));
end

