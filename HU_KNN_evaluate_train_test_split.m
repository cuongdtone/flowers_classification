clc
clear all

test = 'test.mat'
train = 'datasets_humoment.mat'

K = 7;

%load test set
datasets_test = load(test);
datasets_test = datasets_test.datasets;
N = length(datasets_test);

%load model
datasets = load(train);
datasets = datasets.datasets;

predict = [];
truth = [];
for i=1:N
    n1 = datasets_test(i, :);
    label_test = n1(1);
    data_test = n1(2:end);
    pred = knn(data_test, datasets, K, -1);
    truth(end+1) = label_test;
    predict(end+1) = pred;
end
    
C = confusionmat(truth', predict', 'Order', [1,2,3,4,5])
plotConfMat(C, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'})





