%

    input_folder='C:\Users\NgocThien\Desktop\flowers_classification\Put test set here\lotus'
    list=dir(input_folder);
    filenames={list(~[list.isdir]).name}; 
    for j=1:length(filenames)
        name=strsplit(filenames{j},'.')
        jpeg_path=[input_folder,'\',char(name(1)),'.jpeg']
        jpg_path=[input_folder,'\',char(name(1)),'.jpg']
        I=imread(jpeg_path);
        imwrite(I,jpg_path);
    end




