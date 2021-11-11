clc
clear all

path = 'datasets_humoment.mat'

datasets = load(path);
datasets = datasets.datasets;

n1 = datasets(11, :);
label_test = n1(1);
data_test = n1(2:end);

knn(data_test, path)





