format long
%path='./images/hibiscus1.jpg'
%path='./images/hibiscus2.jpg'
%path='./images/daisy1.jpg'
%path='./images/daisy2.jpg'
%path='./images/lotus1.jpg'
%path='./images/lotus2.jpg'
%path='./images/rose1.jpg'
%path='./images/rose2.jpg'
%path='./images/sunflower2.jpg'
path='./images/sunflower1.jpg'


%path and image name
name_img = strsplit(path,'.');
name_img = name_img(1);
%original image
original_image=imread(path);
imshow(original_image);

%extract mask 
binary_image = segment_color(original_image, 2);
binary_image = ExtractNLargestBlobs(binary_image, 1);
binary_image = imfill(binary_image, 'holes');

binary_image=uint8(binary_image(:,:,1));
%apply mask with original image to create gray image
gray_image=rgb2gray(original_image);
gray_image = binary_image.*gray_image;

%crop gray image
gray_image=crop_image(gray_image);

test=[2,extract_HOG(gray_image,[64,64])];
k=1;
%predict
[label,name]=predict1(test,k)

