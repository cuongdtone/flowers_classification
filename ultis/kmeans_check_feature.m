
clc
clear all

train = 'hu_3.mat';
datasets = load(train);
datasets = datasets.datasets;

data = datasets(:, 2:end);
data = -sign(data).*(log10(abs(data)));
label = datasets(:, 1);

partition = [];
for i=1:length(label)-1
    if label(i) ~= label(i+1)
        partition(end+1) = i
    end
end

n = kmeans(data, 5);

pred_1 = n(1:partition(1));
pred_2 = n(partition(1)+1:partition(2));
pred_3 = n(partition(2)+1:partition(3));
pred_4 = n(partition(3)+1:partition(4));
pred_5 = n(partition(4)+1:end);

true_1 = mode(pred_1);
true_2 = mode(pred_2);
true_3 = mode(pred_3);
true_4 = mode(pred_4);
true_5 = mode(pred_5);

true_num_1 = [true_1,histc(pred_1(:),true_1)];
true_num_2 = [true_3,histc(pred_2(:),true_2)];
true_num_3 = [true_3,histc(pred_3(:),true_3)];
true_num_4 = [true_4,histc(pred_4(:),true_4)];
true_num_5 = [true_5,histc(pred_5(:),true_5)];

true_num = [true_num_1
            true_num_2
            true_num_3
            true_num_4
            true_num_5]
        
        
            


