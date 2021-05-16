function d=D_matrix(A)
[m,n]=size(A);
d=eye(m);
D=zeros(m,m);
k=round(m^(0.5));
for i=1:m
diff_square=bsxfun(@minus,A,A(i,:)).^2;
sum_diff_square=sum(diff_square,2);
sqrt_sum=sum_diff_square.^0.5;
value(i,:)=(sqrt_sum)';
end
for i=1:m
    [m,n]=sort(value(i,:));
    for v_l=1:k
        D(i,n(v_l))=1;
        D(n(v_l),i)=1;
    end
end
temp=sum(D,2);
for i=1:length(d)
d(i,i)=temp(i,1);
end
