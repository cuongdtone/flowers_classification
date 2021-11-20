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
function datasets = create_test_set(path)
    name_class = {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'};
    datasets = [];

    for i = 1:5
        dataset_path = [path,'\', char(name_class(i))]    ;
        files = dir([dataset_path, '\*.jpg']);
        list_S = [];
        list_label = [];
        for j = 1:length(files)
            image = imread([dataset_path, '\',files(j).name]);

            
            binary_mask = segment_color(image, 2);
            binary_mask = double(ExtractNLargestBlobs(binary_mask, 1)); %value 0 and 1
            binary_mask = imfill(binary_mask, 'holes');
            binary_mask = logical(binary_mask(:,:,1));
            
            S = hu_moment(binary_mask);
            label = i;
            data = [label, S(1), S(2), S(3), S(4), S(5), S(6), S(7)];
            datasets(end+1, :) = data;
        end
    end
    save test datasets
