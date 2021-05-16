function[u1,u2,D,time]=lsvm(train_data,ep1,ep2,c1,c2,c3,itmax,tol)
%lsvm with nonlinear kernel for min 1/2*u1'*Q*u1-e'*u1 s.t. u1=>0 and min 1/2*u2'*Q*u2-e'*u2 s.t. u2=>0
[m,n]=size(train_data);
e=ones(m,1);
y=train_data(:,n);
data=train_data(:,1:end-1);
D=D_matrix(data);
 tstart = cputime;
%K=zeros(m,m);
%for i=1:m
 %   for j=1:m
  %      nom=norm(train_data(i,1:n-1)- train_data(j,1:n-1));
   %     K(i,j)=exp( -mu * nom * nom );
    %end
%end
K=train_data(:,1:n-1);
time=0;


%% Training and application of SOR

    G=[K e];
    G1= inv(G'*D*G+ c3.*speye(n));
    H=G*G1*G';
    r1=y'+ep1*e'-y'*D*H;
    r2=-y'+ep2*e'+y'*D*H;
    Q1=H;
    Q1=(Q1+Q1')/2;
    Q2=H;
    Q2=(Q2+Q2')/2;
     initial_train_time=tic;
    u1=SOR(Q1,r1,c2,c1,0.01);
    u2=SOR(Q2,r2,c2,c1,0.01); 
    time = toc(initial_train_time);
   