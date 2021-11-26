clc
clear all

% Support to database restructuring
% Dev: Cuong Tran

%Labeling
class_index_move = 18
name_class = 'lily'

dataset_path = ['datasets\', name_class]
mkdir(dataset_path)

label = load('F:\archive\imagelabels.mat');
label = label.labels;
path = 'F:\archive\jpg\';
files = dir([path, '\*.jpg']);
for i = 1:length(files)
        if label(i) == class_index_move
                scr = [path, files(i).name];
                copyfile(scr, dataset_path);
        end
end
