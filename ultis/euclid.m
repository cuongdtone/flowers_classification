function d = euclid(A, B)
% Calculate the distance between two vectors with the same dimension based
% on Euclid method
% Dev: Cuong Tran
n = length(A);
d = 0;
for i = 1:n
    d = d + (A(i)-B(i))*(A(i)-B(i));
end
d = sqrt(d);

