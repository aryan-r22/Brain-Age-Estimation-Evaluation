function test=test_train_regression (train_data,test_data,ep1,ep2,c3,u1,u2)
[s1,s2]=train_regression(train_data,ep1,ep2,c3,u1,u2);
test=test_regression(train_data,test_data,s1,s2);
function [s1,s2]=train_regression(train_data,ep1,ep2,c3,u1,u2)
[no_input,no_col]=size(train_data);
% A = [train_data; test_data];
e=ones(no_input,1);
% initial_train_time=cputime;
%K=zeros(m,m);
%for i=1:m
 %   for j=1:m
  %      nom=norm(train_data(i,1:n-1)- train_data(j,1:n-1));
   %     K(i,j)=exp(-(nom*nom)/(2*mu^2));
    %end
%end
K=train_data(:,1:no_col-1);
G = [K e];
%GTG = G'*G+0.00001*speye(no_col);
GTG = G'*G+c3*speye(no_col);
G1=inv(GTG);
y= train_data(:,no_col);
%s1=[w1 b1]' 
%s2=[w2 b2]'
s1=G1*G'*(y-e*ep1-u1);
s2=G1*G'*(y+e*ep2+u2);
% train_time = cputime - initial_train_time
function test=test_regression(train_data,test_data,s1,s2)
[no_input,no_col]=size(train_data);
[no_test_pt,no_col_pt] = size(test_data);
e = ones(no_test_pt,1);
%ker_row = zeros(no_test_pt,no_input);
% K=zeros(no_input,no_input);
% test1 = zeros(no_test_pt,1);
% test2 = zeros(no_test_pt,1);

%for k=1:no_test_pt
 %   for i=1:no_input
  %      ker_row(k,i)=exp(-(norm(test_data(k,1:no_col_pt)-train_data(i,1:no_col-1))^2)/(2*mu^2));
   % end  
%end
    ker_row=test_data;
    test1=[ker_row e]*s1;
    test2=[ker_row e]*s2;
    test=(test1+test2)/2;
      




