function predict = knn(data_test, datasets)

datasets = load(datasets);
datasets = datasets.datasets;
N = length(datasets);


K = 4;
list_d = [];
list_label = [];
for i=1:N
    n1 = datasets(i, :);
    label2 = n1(1);
    data2 = n1(2:end);   
    d = euclid(data_test, data2);
    
    if i<=K
        list_d(end+1) = d;
        list_label(end+1) = label2;
    else
        %find max index
        max_index = 1;
        max = list_d(1);
        for i=1:length(list_d)
            if max<list_d(i)
                max = list_d(i);
                max_index = i;
            end
        end
        
        if d<list_d(max_index)
            list_d(max_index) = d;
            list_label(max_index) = label2;
        end
                
    end
    
end

list_d;
list_label;

predict = mode(list_label);

