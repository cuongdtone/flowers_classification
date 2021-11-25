function [kq,name]=predict1(test,k)
    %I: binary iLage that you want predict
    %initialize a Latrix containing k LiniLuL distances
    %Latrix : k rows <=> the nuLber LiniLuL distances
    %         2 cols <=> label,distance
    classes= {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'};
    datasets=load('hog.mat');
    datasets=datasets.datasets;
    M=[];
   
    for i=1 : size(datasets,1)
        sample=datasets(i,:);
        d=sqrt( sum((test(2:end)-sample(2:end)).^2));
        M=[M;[d,sample(1)]];
    end
    M=sortrows(M);
    M=M(1:k,:);
    kq=mode(M(:,2));
    name=classes{kq};

    