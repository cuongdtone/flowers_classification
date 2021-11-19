clc
clear all

% Evaluate model HU-KNN based on LOOCV method
% Plot Confusion Matrix 
% Dev: Cuong Tran, Thien Le Van, Duy Ngu Dao

% load model
train = 'datasets_humoment.mat'
K = 7;
datasets = load(train);
datasets = datasets.datasets;
N = length(datasets)

predict = [];
truth = [];
for i=1:N
    n1 = datasets(i, :);
    label_test = n1(1);
    data_test = n1(2:end);
    
    pred = knn(data_test, datasets, K, i);
    
    truth(end+1) = label_test;
    predict(end+1) = pred;
end

%plot CM
C = confusionmat(truth', predict', 'Order', [1,2,3,4,5])
plotConfMat(C, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'})





