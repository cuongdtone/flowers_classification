% Create test set from origin dataset
% Structure of datasets:
%       datasets
%               daisy
%                       img1.jpg
%                       image2.jpg
%               lotus
%                       img1.jpg
%                       image2.jpg
%               ...
% Dev: Cuong Tran

%path = 'Put test set here\'
function datasets = create_test_set(path, feature_method)
    addpath(genpath('.\ultis'));
    name_class = {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'};
    datasets = [];

    for i = 1:5
        dataset_path = [path,'\', char(name_class(i))];
        files = get_file_image(dataset_path);
        list_S = [];
        list_label = [];
        for j = 1:length(files)
            image = imread(files(j).path);
            
            binary_mask = segment_color(image, 2);
            binary_mask = double(ExtractNLargestBlobs(binary_mask, 1)); %value 0 and 1
            binary_mask = imfill(binary_mask, 'holes');
            binary_mask = logical(binary_mask(:,:,1));
            
            if feature_method==1
                S = hu_moment(binary_mask);
            else
                image_gray = rgb2gray(image);
                image_gray(binary_mask==0) = 0;
                image_gray = cut_image(image_gray);
                S = extract_HOG(image_gray,[64,64]);
            end
            label = i;
            data = [label, S];
            datasets(end+1, :) = data;
        end
    end
    save test datasets
