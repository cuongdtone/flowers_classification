 % Please create test data with code create_test_set.m

function CM = evaluate_train_test_split(path_test, datasets, model, feature, K)
    %load test set
    datasets_test = load(path_test);
    datasets_test = datasets_test.datasets;
    %K = 7;
    N = size(datasets_test, 1)
    predict = [];
    true = [];
    for i=1:N
        n1 = datasets_test(i, :);
        label_test = n1(1);
        data_test = n1(2:end);
        if model==1
            pred = knn(data_test, datasets, K, -1);
        elseif feature==1
            load hu_net
            data_test = -sign(data_test).*(log10(abs(data_test)));
            pred = net(data_test');
            pred = vec2ind(pred);
        else
            load hog_net
            pred = net(data_test');
            pred = vec2ind(pred);
        end         
        true(end+1) = label_test;
        predict(end+1) = pred;
    end
    CM = confusionmat(predict', true', 'Order', [1,2,3,4,5]);
    %plotConfMat(C, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'})
end


