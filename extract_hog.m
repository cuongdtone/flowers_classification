function all_feature = extract_hog(im_org, size_window, stride)
% *****************************************
% function: extract feature hog of a image
% output: vector feature 
% input: + im_org: image original with color is gray
%        + size_window: size of window
%        + stride: step
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% *****************************************
% get size image current
[h, w] = size(im_org);
% check and resize image about size 128x64 or 64x128
if h > w
    im_org = imresize(im_org, [128, 64]);
else
    im_org = imresize(im_org, [64, 128]);
end
% get size image after resize
[h, w] = size(im_org);
% compute number feature of image
number_feature = ((h-size_window)/stride + 1)*((w-size_window)/stride + 1)*36;
% create a vector feature original have value 0 with size is number feature
all_feature = zeros(1, number_feature);
% initialization count
count_feature = 1;
% get window of a image
for y=0:stride:h-size_window
    for x=0:stride:w-size_window
        %get window of image with size is size window
        im_window = im_org(y+1:y+size_window, x+1:x+size_window);
        % initialization vector hog with 36 feature
        value_hog36 = zeros(1, 36);
        count = 1;
        % split window and compute vector feature hog
        for j=0:stride:size_window-stride
            for i=0:stride:size_window-stride
                % get image hog of a image window with size stride
                im_hog = im_window(j+1:j+stride, i+1:i+stride);
                % compute vector hog
                vector_hog = hog_feature(im_hog);
                % assign vecotr hog 
                value_hog36(1, count:count+stride) = vector_hog;
                count = count + stride + 1;
            end
        end
        % Normalize vector hog with 36 feature
        K = sqrt(sum(value_hog36.^2));
        value_hog_normalize = value_hog36/K;
        % change value NaN -> 0
        value_hog_normalize(isnan(value_hog_normalize)) = 0;
        % assign vector hog 36
        all_feature(1, count_feature:count_feature+35) = value_hog_normalize;
        count_feature = count_feature + 36;
    end
end
