% *****************************************
% PROGRAM PREDICT AND DRAW CONFUSION MATRIX KNN
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
path_train = 'D:\ky_thuat_nhan_dang\datasets_seg\datasets_hog_train.xlsx';
path_test = 'D:\ky_thuat_nhan_dang\datasets_seg\datasets_hog_test.xlsx';
% load dataset
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
% processing labels about format 0 0 0 0 1
label_train = zeros(row_train, num_class);
label_test = zeros(row_test, num_class);
for i=1:row_train
    if i <= row_test
        label_test(i, label_test_index(i, 1)) = 1;
    end
    label_train(i, label_train_index(i, 1)) = 1;
end
% initialization number cluster
K_clus = 3;
% get row and col of label test
[row, col] = size(label_test);
% initialization matrix label predict
list_label_pre = zeros(row, col);
[row, col] = size(test);
for i=1:row
    % get size train
    [row, col] = size(train);
    % create sample 
    sample = ones(row, col).*test(i,:);
    % compute distance euclid square
    [euclid_square, id_eu] = sort(sum((sample-train).^2, 2));
    id = [];
    % extract inform of K label
    for j=1:length(id_eu(1:K_clus, :))
        id = [id; label_train(id_eu(j), :)];
    end
    % compute sum and get id label.
    [value_max, id_predict] = max(sum(id, 1));
    % get index label true
    [label_max_true, index_true] = max(label_test(i, :));
    list_label_pre(i, id_predict) = 1;
    fprintf('------------------------------\n');
    fprintf('---------------HOA %d--------------\n', i);
    fprintf('Predict flower: %s\n', string(class(id_predict)));
    fprintf('True flower: %s\n', string(class(index_true)));
end
% draw confusion matrix
plotconfusion(label_test', list_label_pre')