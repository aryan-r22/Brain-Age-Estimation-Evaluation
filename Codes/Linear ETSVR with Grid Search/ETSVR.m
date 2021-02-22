function PredictY=ETSVR(TestX,DataTrain,FunPara)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ETSVR: An varepsilon-twin support vector machine for regression
% PredictY= ETSVR(TestX,DataTrain,FunPara)
% 
% Input:
%  TestX - Test Data matrix. Each row vector of fea is a data point.
%  DataTrain - stuct value in Matlab-----Training data.
%      
%   
%   FunPara - Struct value in Matlab
%       FunPara.p1: [0,inf] Paramter to tune the weight;
%       FunPara.p2: [0,inf] Paramter to tune the weight;
%       FunPara.p3: [0,inf] Paramter to tune the weight;
%       FunPara.p4: [0,inf] Paramter to tune the weight;
%       FunPara.p5: [0,inf] Paramter to tune the weight;
%       FunPara.p6: [0,inf] Paramter to tune the weight;
%
%       kerfPara: kernel parameters. See kernelfun.m;
% 
% Output:
%     Predict_Y - Predict value of the TestX.
% 
% Examples:
% load SincTN1.mat X Y TestX TestY
% DataTrain.X = X;
% DataTrain.Y = Y;
% FunPara.p1=2^(-1);
% FunPara.p2=2^(-1);
% FunPara.p3=0.01;
% FunPara.p4=0.01;
% FunPara.p5=0.1;
% FunPara.p6=0.1;
% FunPara.kerfPara.type = 'rbf';
%           FunPara.kerfPara.pars = 3;
%           PredictY= ETSVR(TestX,DataTrain,FunPara);
% 
% Reference: Yuan-Hai Shao, Chun-Hua Zhang, Zhi-Min Yang, Ling Jing, Nai-Yang Deng,
% "An varepsilon-twin support vector machine for regression", Neural Comput & Applic,
% 2012, DOI 10.1007/s00521-012-0924-3.
%
%    Version 1.0 --Jun/2013 
%
%    Written by Yuan-Hai Shao (shaoyuanhai21@163.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initailization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tic;
c1 = FunPara.p1;
c2 = FunPara.p2;
c3 = FunPara.p3;
c4 = FunPara.p4;
eps1 = FunPara.p5;
eps2 = FunPara.p6;
kerfPara = FunPara.kerfPara;
m = size(DataTrain.X,1);
n = size(DataTrain.X,2);
e = ones(m,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute Kernel 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kerfPara = FunPara.kerfPara;
if strcmp(kerfPara.type,'lin')
        G = [DataTrain.X e];
        I = eye(n+1);
else
        G = [kernelfun(DataTrain.X,kerfPara) e];
        I = eye(m+1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Train Data using SOR solver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    U1 = (G'*G+c3*I)\G';
    U2 = (G'*G+c4*I)\G';    
    H1 = G*U1;  H2 = G*U2;
    H1=(H1+H1')/2; H2=(H2+H2')/2;
    f1 = DataTrain.Y'*H1 - (DataTrain.Y' + eps1*e');  
    f2 = -DataTrain.Y'*H2 - (DataTrain.Y' - eps2*e');
    alpha=SOR(H1,f1,0.9,c1,0.01);
    gamma=SOR(H2,f2,0.9,c2,0.01); 
    v1 = U1*(DataTrain.Y - alpha);
    v2 = U2*(DataTrain.Y + gamma);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predict and output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
e=ones(size(TestX,1),1);
m = size(v1,1);
if strcmp(kerfPara.type,'lin')
    Y1=TestX*v1(1:m-1)+v1(m)*e;
    Y2=TestX*v2(1:m-1)+v2(m)*e;        
else
    H=kernelfun(TestX,kerfPara,DataTrain.X);
    Y1=H*v1(1:m-1)+v1(m)*e;
    Y2=H*v2(1:m-1)+v2(m)*e;
end
    DarwY.Y1 = Y1 - eps1;
    DarwY.Y2 = Y2 + eps1;
    PredictY=0.5*(Y1+Y2);
end
%plot(TestX,PredictY)

