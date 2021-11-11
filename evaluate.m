clc
clear all

test = 'test.mat'
train = 'train.mat'

K = 5

datasets = load(test);
datasets = datasets.datasets;
N = length(datasets);


predict = [];
truth = [];
for i=1:N
    n1 = datasets(i, :);
    label_test = n1(1);
    data_test = n1(2:end);
    
    pred = knn(data_test, train, K);
    
    truth(end+1) = label_test;
    predict(end+1) = pred;
end
    
truth(1:45)
predict(1:45)



C = confusionmat(truth', predict', 'Order', [1,2,3,4,5])
plotConfMat(C, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'})





