function t = one_hot(class_idx)
N = length(class_idx);
m = max(class_idx);
mat = eye(m);
t = [];

for i=1:N
    for idx=1:m
        if class_idx(i) == idx
            t(:, end+1) = mat(idx, :);
        end
    end
end


