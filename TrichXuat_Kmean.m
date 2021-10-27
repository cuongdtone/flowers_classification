clc 
clear

image = imread('111.jpg');
gray = rgb2gray(image);
size(image)
%# Filter image
G = fspecial('gaussian',[5 5],2);
Ig = imfilter(image,G,'same');
%Ig = image;
figure %1
imshow(Ig)

%Segment color
nColors = 2;
segmented_images = segment_color(Ig, nColors);


imshow(segmented_images)

object = uint8(255 * segmented_images);
edge = edge(object, 'Canny');
figure %2
imshow(edge)

%Find biggest contour
out = find_biggest_contour(edge);
figure
imshow(out);

%Fill contour
interior_filled = fill_contour(out);

figure
imshow(interior_filled, []);

%Create mask
BW = image;
BW(:,:,1) = interior_filled;
BW(:,:,2) = interior_filled;
BW(:,:,3) = interior_filled;

%Crop image with mask
object = Ig;
object(BW ==0) = 0;
figure;
imshow(object);