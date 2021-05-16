function test=test_train_regression (train_data,test_data,c2,c3,u1,u2,D)
[s1,s2]=train_regression(train_data,c2,c3,u1,u2,D);
test=test_regression(train_data,test_data,s1,s2,D);
function [s1,s2]= train_regression(train_data,c2,c3,u1,u2,D)
[no_input,no_col]=size(train_data);
% A = [train_data; test_data];
e=ones(no_input,1);
% initial_train_time=cputime;
K=zeros(no_input,no_input);
%for i=1:no_input
%    for j=1:no_input
 %       nom=norm(train_data(i,1:no_col-1)- train_data(j,1:no_col-1));
  %      K(i,j)=exp( -mu * nom * nom );
   % end
%end
K=train_data(:,1:no_col-1);
G = [K e];
G1= inv(G'*D*G + c3*speye(no_col));%ep = regularization term
y= train_data(:,no_col);

s1=G1*G'*(D*y-u1);
s2=G1*G'*(D*y+u2);
% train_time = cputime - initial_train_time
function test=test_regression(train_data,test_data,s1,s2,D)
[no_input,no_col]=size(train_data);
[no_test_pt,no_col_pt] = size(test_data);
e = ones(no_test_pt,1);
%ker_row = zeros(no_test_pt,no_input);
% K=zeros(no_input,no_input);
% test1 = zeros(no_test_pt,1);
% test2 = zeros(no_test_pt,1);

%for k=1:no_test_pt
 %   for i=1:no_input
  %      ker_row(k,i)=exp(-mu*(norm(test_data(k,1:no_col_pt-1)-train_data(i,1:no_col-1))^2));
   % end  
%end
    ker_row=test_data;
    test1=[ker_row e]*s1;
    test2=[ker_row e]*s2;
    test=(test1+test2)/2;      






