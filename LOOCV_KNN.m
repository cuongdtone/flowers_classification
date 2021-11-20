% *****************************************
% PROGRAM PREDICT AND DRAW CONFUSION MATRIX USE LOOCV KNN
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% NOTE:
% - numbers folder in data == number class initialize
% *****************************************
clear
%*******************AREA CONFIG DATA*******************
% initialization name class
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
num_class = 5;
% initialization number cluster
K_clus = 5;
% path folder data
path_train = 'D:\ky_thuat_nhan_dang\datasets\dataset_segment\datasets_hu_train.xlsx';
%*******************AREA PROCESSING DATA***************
% load dataset
fprintf('Load and processing data ...\n')
datasets = xlsread(path_train);
% size data
[row_data, col_data] = size(datasets);
% div data
data = datasets(:, 2:col_data);
label_index = datasets(:, 1);
% print number file train and test
fprintf('Tong so file data: %d\n', row_data);
fprintf('Finish processing data...\n')
% processing labels about format 0 0 0 0 1
label_data = zeros(row_data, num_class);
for i=1:row_data
    label_data(i, label_index(i, 1)) = 1;
end
%*******************AREA COMPUTE KNN AND PREDICT USE LOOCV***************
% initialization matrix label predict
index_predict = zeros(row_data, 1);
fprintf('Start compute knn and predict use loocv...\n')
for i=1:row_data
    % get data test and train
    test = data(i, :);
    train = [data(1:i-1, :); data(i+1:row_data,:)];
    label_train = [label_data(1:i-1, :); label_data(i+1:row_data,:)];
    % compute and predict knn
    id_predict = KNN(test, train, label_train, K_clus);
    % get index label true
    index_predict(i, :) = id_predict;
end
fprintf('Finish.\n')
%*******************AREA PLOT CONFUSION MATRIX***************
% draw confusion matrix
idx_cls = [linspace(1, num_class, num_class)];
C = confusionmat(label_index', index_predict', 'Order', idx_cls);
plotConfMat(C', class)  
