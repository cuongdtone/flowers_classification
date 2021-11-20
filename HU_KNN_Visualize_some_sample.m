clc;
clear all;

% Set image (format .jpg or you can change at line 8) in directory name Put test data here
% For each image, one figure show original image, mask and predict (title)
% Dev: Cuong Tran, Thien Le Van, Duy Ngu Dao

path = 'Put test data here';
files = dir([path, '\*.jpg']);
length(files);

%load model
train = 'datasets_humoment.mat';
K = 7;
datasets = load(train);
datasets = datasets.datasets;
name_class = {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'};


for i = 1:length(files)
    image = imread([path, '\',files(i).name]);
    % Segment
    binary_mask = segment_color(image, 2);
    binary_mask = double(ExtractNLargestBlobs(binary_mask, 1)); %value 0 and 1
    binary_mask = imfill(binary_mask, 'holes');
    %binary_mask = image./255;
    %size(binary_mask)
    
    % Hu Moment vector
    S = hu_moment(binary_mask);
    % Predict
    predict = knn(S, datasets, K, -1);
  
    figure
    subplot(121)
    imshow(image)
    title(['Predict: ', name_class(predict)])
    subplot(122)
    imshow(binary_mask*255)
    title(['Predict: ', name_class(predict), ' Mask'])   
end
    
    