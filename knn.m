function predict = knn(data_test, datasets, K, pass_element)

% Classification with KNN method
% Dev: Cuong Tran

% data_test: one point data
% datasets: matrix of labels and datas
% K = int and >1: Number of template matching
% Pass_element: index of the data point to be ignored (for LOOCV)

% pass element = i : 0<i<len(datasets) remove data point i from training set
% pass element = -1: don't remove any point

N = length(datasets);
list_d = []; % K distance from (test data to K datas) in training set
list_label = []; % corresponding label
except = -1; %template match
for i=1:N
    if i ~= pass_element
        n1 = datasets(i, :);
        label2 = n1(1);
        data2 = n1(2:end);   
        d = euclid(data_test, data2);
        
        if d<0.0001
            except = label2;
        end
        
        if i<=K %initial K distance
            list_d(end+1) = d;
            list_label(end+1) = label2;
        else %Update list K
            %find max index
            max_index = 1;
            max = list_d(1);
            for i=1:length(list_d)
                if max<list_d(i)
                    max = list_d(i);
                    max_index = i;
                end
            end
            %Update new data
            if d<list_d(max_index)
                list_d(max_index) = d;
                list_label(max_index) = label2;
            end

        end
    end
    
end

if except ~= -1
    %template match
    predict = except;
else
    %Return most frequent class
    predict = mode(list_label); 
end

