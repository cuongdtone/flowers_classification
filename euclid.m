function d = euclid(A, B)

n = length(A);
d = 0;
for i = 1:n
    d = d + (A(i)-B(i))*(A(i)-B(i));
end
d = sqrt(d);

