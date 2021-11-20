function id_predict = Template_matching(data_test, data_train, label_train) 
% *****************************************
% function: Compute Template Matching
% output: id class predict 
% input: + data_test: feature test
%        + data_train: matrix feature train data
%        + label_train: label train
%        + K_clus: number cluster
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% *****************************************
[row, col] = size(data_train);
sample = ones(row, col).*data_test;
% compute distance euclid square
euclid_square = sum((sample-data_train).^2,2);
% find distance euclid square min and index
[value_min, index] = min(euclid_square);
% get vector label predict
predict = label_train(index, :);
% find index label predict have value = 1
[label_max_pre, id_predict] = max(predict);
end