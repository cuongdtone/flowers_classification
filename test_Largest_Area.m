clc;
clear all;

path = 'C:\Users\Cuong Tran\Desktop\mfilektnd\datasets_seg\lotus\image_01946.tif'
image = imread(path);

image = ExtractNLargestBlobs(image, 1);
image = imfill(image, 'holes');

imshow(image)