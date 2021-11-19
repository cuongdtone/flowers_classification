% *****************************************
% PROGRAM PREDICT AND DRAW CONFUSION MATRIX ANN
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% NOTE:
% - numbers folder in data == number class initialize
% *****************************************
clear
% initialization name class
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
num_class = 5;
% path folder data
path_train = 'D:\ky_thuat_nhan_dang\datasets_seg\dataset_gray\datasets_hog_train.xlsx';
path_test = 'D:\ky_thuat_nhan_dang\datasets_seg\dataset_gray\datasets_hog_test.xlsx';
% load dataset
fprintf('Load and processing data ...\n')
train_data = xlsread(path_train);
test_data = xlsread(path_test);
% size data
[row_train, col_train] = size(train_data);
[row_test, col_test] = size(test_data);
% div data
data_train = train_data(:, 2:col_train);
data_test = test_data(:, 2:col_test);
label_train_index = train_data(:, 1);
label_test_index = test_data(:, 1);
% print number file train and test
fprintf('Tong so file train: %d\n', row_train);
fprintf('Tong so file test: %d\n', row_test);
% processing labels about format 0 0 0 0 1
label_train = zeros(row_train, num_class);
label_test = zeros(row_test, num_class);
fprintf('Finish processing data...\n')
for i=1:row_train
    if i <= row_test
        label_test(i, label_test_index(i, 1)) = 1;
    end
    label_train(i, label_train_index(i, 1)) = 1;
end
% create layers
net = patternnet(100);
fprintf('Start training...\n')
% training
net = train(net,data_train',label_train');
fprintf('Finish training.\n')
% predict
predict = net(data_test');
% classes = vec2ind(y);  
plotconfusion(label_test', predict)           