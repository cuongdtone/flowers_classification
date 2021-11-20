% *****************************************
% PROGRAM PREDICT AND DRAW CONFUSION MATRIX USE HOLD OUT
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% NOTE:
% - numbers folder in data == number class initialize
% *****************************************
clear
% initialization name class
%*******************AREA CONFIG DATA*******************
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
num_class = 5;
K_clus = 1;
% path folder data
path_train = 'D:\ky_thuat_nhan_dang\datasets\dataset_segment\datasets_hu_train.xlsx';
path_test = 'D:\ky_thuat_nhan_dang\datasets\dataset_segment\datasets_hu_test.xlsx';
%*******************AREA PROCESSING DATA***************
% load dataset
fprintf('Load and processing data ...\n')
train_data = xlsread(path_train);
test_data = xlsread(path_test);
% size data
[row_train, col_train] = size(train_data);
[row_test, col_test] = size(test_data);
% div data
train = train_data(:, 2:col_train);
test = test_data(:, 2:col_test);
label_train_index = train_data(:, 1);
label_test_index = test_data(:, 1);
% print number file train and test
fprintf('Tong so file train: %d\n', row_train);
fprintf('Tong so file test: %d\n', row_test);
fprintf('Finish processing data...\n')
% processing labels about format 0 0 0 0 1
label_train = zeros(row_train, num_class);
label_test = zeros(row_test, num_class);
for i=1:row_train
    if i <= row_test
        label_test(i, label_test_index(i, 1)) = 1;
    end
    label_train(i, label_train_index(i, 1)) = 1;
end
%*******************AREA COMPUTE KNN USE HOLD OUT***************
[row, col] = size(label_test);
index_predict = zeros(row, 1);
% predict
[row, col] = size(test);
fprintf('Start compute knn use hold out...\n')
for i=1:row
    % compute and predict knn
    id_predict = KNN(test(i,:), train, label_train, K_clus);
    % get index label true
    index_predict(i, 1) = id_predict;
end
fprintf('Finish.\n')
%*******************AREA PLOT CONFUSION MATRIX***************
idx_cls = [linspace(1, num_class, num_class)];
C = confusionmat(label_test_index', index_predict', 'Order', idx_cls);
plotConfMat(C, class)  