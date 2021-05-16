function[u1,u2]=lsvm2(train_data,ep1,ep2,c1,c2,mu,itmax,tol)
%lsvm with nonlinear kernel for min 1/2*u1'*Q*u1-e'*u1 s.t. u1=>0 and min 1/2*u2'*Q*u2-e'*u2 s.t. u2=>0
[m,n]=size(train_data);
e=ones(m,1);
y=train_data(:,n);
K=zeros(m,m);
for i=1:m
    for j=1:m
        nom=norm(train_data(i,1:n-1)- train_data(j,1:n-1));
        K(i,j)=exp(-(nom*nom)/(2*mu^2));
    end
end
G=[K e];I=speye(m);
GTG = G'*G+ 0.0001*speye(m+1);
G1=inv(GTG);
H=G*G1*G';
r1=(H-I)*(y-ep1*e);
r2=(I-H)*(y+ep2*e);
%Input: train_data,c1,itmax,tol; output: u1,u2
%here itmax represents maximum no. of iterations, tol represents tolerated nonzero error at termination 
alpha1=1.9/c1;alpha2=1.9/c2; it=0;
Q1=I/c1+G*G1*G';
Q2=I/c2+G*G1*G';
P1=c1*(I-(c1/(1+c1))*H);
P2=c2*(I-(c2/(1+c2))*H);
% P=inv(Q1); P2=inv(Q2);
u1=P1*e; oldu1=u1+1;
u2=P2*e; oldu2=u2+1;
while it<itmax && norm (oldu1-u1)>tol
    oldu1=u1;
    u1=P1*(r1+pl(Q1*u1-r1-alpha1*u1));
    it=it+1;
end;
it = 0;
while it<itmax && norm (oldu2-u2)>tol
    oldu2=u2;
    u2=P2*(r2+pl(Q2*u2-r2-alpha2*u2));
    it=it+1;
end
% opt1=norm(u1-oldu1); 
% opt2=norm(u2-oldu2); for calculating opt1 and opt2
function pl=pl(x); pl=(abs(x)+x)/2;