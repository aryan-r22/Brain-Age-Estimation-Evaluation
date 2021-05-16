function [Arr] = matrix2Array(M)
[row,col] = size(M);
Arr = zeros(row*col,1);
count = 0;
for i = 1:row
    for j = 1:col
        count = count+1;
        Arr(count) = M(i,j);
    end
end