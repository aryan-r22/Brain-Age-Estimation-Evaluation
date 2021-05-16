function [y] = arrayToMatrix(yd0,B)
% yd0 is a column vector of size multiple of size of B
% B is also a cloumn vector
col = size(B,1);
y = zeros(size(B,1),size(B,1));
count = 1;
for i =1:col:size(yd0,1);
    y(count,:) = yd0(i:i+col-1)';
    count = count+1;
end