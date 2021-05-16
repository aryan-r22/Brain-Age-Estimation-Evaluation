%   This is twin svr method for nonlinear case using QPP from toolbox
%   Solution of two minimization problems are solved.
function [ytest0]=test_train(train_data,test_data,ep1,ep2,c1,c2,mu)
[s1,s2]=train_regression(train_data,ep1,ep2,c1,c2,mu);
[ytest0] =test_regression(train_data,test_data,s1,s2,mu);
function [s1,s2]=train_regression(train_data,ep1,ep2,c1,c2,mu)
[no_input,no_col]=size(train_data);
%  A=[train_data; test_data];    
    ep = 0.00001;
    K=zeros(no_input,no_input);
    for i=1:no_input
        for j=1:no_input
            nom = norm( train_data(i,1:no_col-1) - train_data(j,1:no_col-1) );
            K(i,j) = exp( -mu * nom * nom ) ;
        end
    end
   [m,n] = size(K)
   I = speye(m);
   e = ones(m,1);
%     y = y1;
   y=train_data(:,no_col);
    
    lowb=zeros(m,1);
    upb1 = c1 * e;
    upb2 = c2 * e;
    G = [K e];
    GTG = G' * G;
    invGTG = inv(GTG + ep * speye(n+1) );
    GINVGT = G * invGTG * G';

    r1 = (-I + GINVGT ) * (y - ep1 * e ) ;
    r2 = (I - GINVGT ) * (y + ep2 * e ) ;
    
    f1 = - r1';
    f2 = - r2';
    
    u1 = quadprog(GINVGT,f1,[],[],[],[],lowb,upb1);
    u2 = quadprog(GINVGT,f2,[],[],[],[],lowb,upb2);
   s1=invGTG*G'*(y - ep1 * e-u1);
   s2=invGTG*G'*(y + ep2 * e+u2);
   
   % %   Testing part starts here    
function [ytest0]=test_regression(train_data,test_data,s1,s2,mu)
[no_input,no_col]=size(train_data);
[no_test_pt,no_col_pt] = size(test_data);
ktest = zeros(no_test_pt,no_input);
     for k=1:test_pt
        for i=1:no_input
            nom = norm( train_data(i,no_col-1) - test_data(k,no_col_pt-1) );
            ktest(k,i) = exp( -mu * nom * nom ) ;
        end
     end
    e1 = ones(test_pt,1);
    ytest0 = [ktest e1]*invGTG*G'*( s1+s2 ) * 0.5; 
    
     plot((1:1:test_pt)',test_data(:,no_col_pt),'r',(1:1:test_pt)',ytest0,'b');
     
%   _____________________________________________________________________________    
 
     
%   _____________________________________________________________________________    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    