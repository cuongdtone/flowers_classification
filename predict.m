function [binary_mask, pred] = predict(image, feature_method, model)

%seg
binary_mask = segment_color(image, 2);
binary_mask = double(ExtractNLargestBlobs(binary_mask, 1)); %value 0 and 1
binary_mask = imfill(binary_mask, 'holes');
binary_mask = logical(binary_mask(:,:,1));

if feature_method==1
    feature = hu_moment(binary_mask);
end

if model==1
    %load model
    train = 'datasets_humoment.mat';
    K = 7;
    datasets = load(train);
    datasets = datasets.datasets;
    name_class = {'Daisy', 'Rose', 'Hibiscus', 'Lotus', 'Sunflower'};
    predict = knn(feature, datasets, K, -1);
end
pred = name_class(predict);