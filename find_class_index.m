clc
clear all

label = load('F:\archive\imagelabels.mat');
label = label.labels;

path = 'F:\archive\jpg\';

files = dir([path, '\*.jpg']);

files(1).name;

class_number = zeros(1, 102);
for i = 1:length(files)
    for clss = 1:102
        if label(i) == clss
            class_number(clss) =  class_number(clss) + 1;
            if  class_number(clss)==2
                img_path = [path, files(i).name]
                img = imread(img_path);
                path_write = ['label\', num2str(clss), '.jpg'];
                imwrite(img, path_write);
            end
        end
    end
end
 class_number