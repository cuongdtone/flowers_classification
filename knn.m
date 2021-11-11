clc
clear
% name class
class = {'Rose', 'Daisy', 'Hibiscus', 'Lotus', 'Sunflower'};
% path folder data
path_data = 'D:\ky_thuat_nhan_dang\datasets_seg\';
% get name file in folder data
list_name = dir([path_data, '*.mat']);
% number feature and number class
train = [];
test = [];
label_train = [];
label_test = [];
for i=1:length(list_name)
    % create path file data
    path = [path_data, list_name(i).name];
    % load file data
    data_file = load(path);
    % get data train
    data = data_file.data;
    % get label
    label = data_file.labels;
    [row, col] = size(data);
    % div data train: 80% test: 20%
    train = [train; data(1:round(0.8*row), :)];
    label_train= [label_train; label(1:round(0.8*row), :)];
    test = [test; data((round(0.8*row) + 1):row, :)];
    label_test = [label_test; label((round(0.8*row) + 1):row, :)];
end
fprintf('Tong so file train: %d\n', length(train));
fprintf('Tong so file test: %d\n', length(test));
[row, col] = size(label_test);
list_label_pre = zeros(row, col);
% predict
K_clus = 10;
for i=1:length(test)
    [row, col] = size(train);
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
plotconfusion(label_test', list_label_pre')