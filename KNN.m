function id_predict = KNN(data_test, data_train, label_train, K_clus) 
% *****************************************
% function: Compute KNN
% output: id class predict 
% input: + data_test: feature test
%        + data_train: matrix feature train data
%        + label_train: label train
%        + K_clus: number cluster
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% *****************************************
% get size train
[row, col] = size(data_train);
% create sample 
sample = ones(row, col).*data_test;
% compute distance euclid square
[euclid_square, id_eu] = sort(sum((sample-data_train).^2, 2));
id = [];
% extract inform of K label
for j=1:length(id_eu(1:K_clus, :))
    id = [id; label_train(id_eu(j), :)];
end
% compute sum and get id label.
[value_max, id_predict] = max(sum(id, 1));
end