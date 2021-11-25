  % Please create test data with code create_test_set.m

function CM = HU_KNN_evaluate_train_test_split(path_test, datasets)
    %load test set
    datasets_test = load(path_test);
    datasets_test = datasets_test.datasets;
    K = 7;
    N = size(datasets_test, 1)
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

    CM = confusionmat(truth', predict', 'Order', [1,2,3,4,5]);
    %plotConfMat(C, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'})



