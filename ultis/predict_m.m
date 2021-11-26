function [binary_mask, pred] = predict_m(image, feature_method, model, K)
addpath(genpath('.\ultis\HOG'))
name_class =  {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'};
%seg
binary_mask = segment_color(image, 2);
binary_mask = double(ExtractNLargestBlobs(binary_mask, 1)); %value 0 and 1
%binary_mask = imfill(binary_mask, 'holes');
binary_mask = logical(binary_mask(:,:,1));

if feature_method==1 && model == 1
    %HU_KNN
    binary_mask = imfill(binary_mask, 'holes');
    feature = hu_moment(binary_mask);
    train = 'datasets_humoment.mat';
    datasets = load(train);
    datasets = datasets.datasets;
    predict = knn(feature, datasets, K, -1);
elseif feature_method==1 && model==2
    %HU-Neural Network
    binary_mask = imfill(binary_mask, 'holes');
    feature = hu_moment(binary_mask);
    feature = -sign(feature).*(log10(abs(feature)));
    load hu_net
    predict = net(feature');
    predict = vec2ind(predict);
    
elseif feature_method==2 && model==1
    %HOG_KNN
    image_gray = rgb2gray(image);
    image_gray(binary_mask==0) = 0;
    image_gray = cut_image(image_gray);
    
    binary_mask = image_gray;
    feature = extract_HOG(image_gray,[64,64]);

    datasets = load('datasets_hog.mat');
    datasets = datasets.datasets;
    predict = knn(feature, datasets, K, -1);
elseif feature_method==2 && model==2
    %HOG_NN
    image_gray = rgb2gray(image);
    image_gray(binary_mask==0) = 0;
    image_gray = cut_image(image_gray);
    
    binary_mask = image_gray;
    feature = extract_HOG(image_gray,[64,64]);
    
    load hog_net
    y = net(feature');
    predict = vec2ind(y);
    
end
    
    

pred = name_class(predict);