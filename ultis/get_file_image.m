function list_file_all = get_file_image(path_data)
%***************************************************
% function: get all path image of a folder
% input: + path_data: path of folder image
% output: a struct include all file image
% access: list_file(i).path 
% program create by Dao Duy Ngu
%***************************************************
% config format file image
class = {'\*.jpg', '\.*png', '\*.jpeg', '\*.tif'};
% initialize struct list file image
list_file_all = struct;
x = 0;
for i = 1:length(class)
    list_file = dir([path_data, char(class(i))]);
    count = 0;
    for j = x+1:x+length(list_file)
        count = count + 1;
        list_file_all(j).path = [path_data, '\', list_file(count).name];
    end
    x = x + length(list_file);
end