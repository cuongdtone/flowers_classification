clc
clear all

path = 'Test'
train = ''

datasets = load(path);
datasets = datasets.datasets;
N = length(datasets);

n1 = datasets(200, :);
label_test = n1(1);
data_test = n1(2:end);

knn(data_test, path)

predict = []
truth = []
for i=1:N
    n1 = datasets(i, :);
    label_test = n1(1);
    data_test = n1(2:end);
    
    pred = knn(data_test, path)
    
    truth(end+1) = label_test
    predict(end+1) = pred
    
plotconfusion(truth,predict)




