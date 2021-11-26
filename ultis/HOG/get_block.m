
function B=get_block(I)
%xtract features for a block, block =  2x2 cells
%       |------|------|
%       |cell1 |cell2 |
%       |------|------|
%       |cell3 |cell4 |
%       |------|------|
%input: block 16X16
%output: 9x4 =36 features
B=[];
for i=1:8:16
    for j=1:8:16
        J=I(i:i+7,j:j+7);
        B=[B,get_cell(J)];
    end
end
K=sqrt(sum(B.^2));
B=B/K;
%remove NaN
B(isnan(B)) = 0; 
