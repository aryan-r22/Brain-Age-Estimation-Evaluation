clc
close all
clear all
rng(1,'twister')
if isfile('best_params.mat')
     % File exists.
disp("File containing best parameters exists")

load('best_params.mat');

load('Data.mat')
Train_Data=Data.Train.GM;
Age_HC_Train_main=Data.Train.Age;

Test_Data_HC=Data.Test.HC.GM;
Age_HC_Test_main=Data.Test.HC.Age;
Test_Data_MCI=Data.Test.MCI.GM;
Test_Age_MCI=Data.Test.MCI.Age;
Test_Data_AD=Data.Test.AD.GM;
Test_Age_AD=Data.Test.AD.Age;

no_dims=100

[ n , m ] = size (Train_Data);

K  = 10 ; % nomber of folds
Foldaccuracy= zeros(1,K);
cvFolds =  zeros(n,1);

for z = 1 :K : n
    for w = 1 : K
        cvFolds(z) = w;
        z = z+1;
        % w = w+1 ;
    end
end
cvFolds = cvFolds( 1:n ,:);






kernel = 'linear';	% kernel type
count=1;



for  i =1:K                                 %for each fold  for i = 1 : K
    testIdx = (cvFolds == i);                % get indices of test instances
    trainIdx = ~testIdx;                     % get indices training instances
    %%  Age Section
    AgeTrain=Age_HC_Train_main(trainIdx,:);
    MainTestAge=Age_HC_Train_main(testIdx,:);
    %%  Voxel Section
    DataTrain_1=Train_Data(trainIdx,:);
    MainTestData_1=Train_Data(testIdx,:);
    %% PCA Data reduction≈
    %no_dims=size(DataTrain_1,1)-1;
    [DataTrain, mapping] = pca(DataTrain_1 , no_dims);
    X2 = MainTestData_1 - repmat(mapping.mean, [size(MainTestData_1, 1) 1]);
    MainTestData = X2 * mapping.M;
       
    
    %% Regression Model
    
    
    %Mdl = fitrsvm(DataTrain,AgeTrain,'Standardize',false,'KernelFunction','linear','OutlierFraction',0.0); % ,'KernelScale','auto' . false
    %Mdl = fitrlinear(DataTrain,AgeTrain,'Regularization','ridge'); % 'Regularization','ridge' or 'lasso';
    clf0=KernelRidge(struct('alpha',best_ap,'kernel',kernel));
    clf0.fit(DataTrain,AgeTrain);
    XX= clf0.predict(MainTestData);
    PredictTest_Before(testIdx,1)=XX;
    
    i
    
end


%% Bias adjustment
p = polyfit(Age_HC_Train_main, (PredictTest_Before-Age_HC_Train_main),1);
q=p(1);
qq=p(2);


PredictTest=[];

Offset=mean(q).*Age_HC_Train_main+mean(qq);
for t=1:size(PredictTest_Before,1)
    PredictTest(t,1)=PredictTest_Before(t,1)-Offset(t,1);
end
%%
MAEtest(1,1)=sum(abs(PredictTest -Age_HC_Train_main))/numel(Age_HC_Train_main)
RMSEtest(:,:)= (mean((PredictTest -Age_HC_Train_main).^2))^0.5;
MEANHCs=mean((PredictTest -Age_HC_Train_main))
[RTest, Pvalue] = corr(Age_HC_Train_main,PredictTest);
R2_Train=RTest.*RTest
SEM = std(PredictTest -Age_HC_Train_main)/sqrt(length(PredictTest -Age_HC_Train_main));               % Standard Error
ts = tinv([0.025  0.975],length(PredictTest -Age_HC_Train_main)-1);      % T-Score
CI = mean(PredictTest -Age_HC_Train_main) + ts*SEM;
CI_train_HC(1)=CI(1);
CI_train_HC(2)=CI(2);

%     plot( Age_HC_Train_main,PredictTest, 'o' )
%     xlabel('Real age (years)')
%     ylabel('Estimated brain age (years)')
%     coeff = polyfit(Age_HC_Train_main,PredictTest,1);
%     xline = linspace( min(min(Age_HC_Train_main),18), max(max(Age_HC_Train_main),90), 2000);
%     yline = coeff(1)*xline+coeff(2);
%     hold on
%     plot(xline,yline,'b-')
%     hold on



%% ON test sets

%% 1 HC
% PCA Data reduction≈

[DataTrain_2, mapping] = pca(Train_Data , no_dims);
X2_HC = Test_Data_HC - repmat(mapping.mean, [size(Test_Data_HC, 1) 1]);
HC_Test_Voxel = X2_HC * mapping.M;


MainData= [   DataTrain_2];
MainTest_HC=[   HC_Test_Voxel];
%Mdl_onTest_HC = fitrsvm(MainData,Age_HC_Train_main,'Standardize',false,'KernelFunction','linear','OutlierFraction',0.0); % ,'KernelScale','auto'
%Mdl_onTest_HC = fitrlinear(MainData,Age_HC_Train_main,'Regularization','ridge'); % 'Regularization','ridge' or 'lasso';
clf1=KernelRidge(struct('alpha',best_ap,'kernel',kernel));
clf1.fit(MainData,Age_HC_Train_main);
PredictTest_HC_Before=clf1.predict(MainTest_HC);

%% Bias adjustment
PredictTest_HC=[];

Offset=mean(q).*Age_HC_Test_main+mean(qq);
for t=1:size(PredictTest_HC_Before,1)
    PredictTest_HC(t,1)=PredictTest_HC_Before(t,1)-Offset(t,1);
end
%%

Mean_HC_Final=mean(PredictTest_HC-Age_HC_Test_main)
MAE_HC_Final=sum(abs(PredictTest_HC-Age_HC_Test_main))/numel(Age_HC_Test_main)
RMSE_HC_Final= (mean((PredictTest_HC-Age_HC_Test_main).^2))^0.5;
[R_HC_Final, Pvalue2] = corr(PredictTest_HC,Age_HC_Test_main);
R2_HC_Final=R_HC_Final.*R_HC_Final;
SEM1 = std(PredictTest_HC-Age_HC_Test_main)/sqrt(length(PredictTest_HC-Age_HC_Test_main));               % Standard Error
ts1 = tinv([0.025  0.975],length(PredictTest_HC-Age_HC_Test_main)-1);      % T-Score
CI1 = mean(PredictTest_HC-Age_HC_Test_main) + ts1*SEM1;
CI_test_HC(1)=CI1(1);
CI_test_HC(2)=CI1(2);
plot( Age_HC_Test_main,PredictTest_HC, 'ro' ,'DisplayName','HC' )
% plot( Age_HC_Test_main,PredictTest_HC-Age_HC_Test_main, 'ro' )


xlabel('Real age (years)')
ylabel('Estimated brain age (years)')
coeff = polyfit(Age_HC_Test_main,PredictTest_HC,1);
xline = linspace( min(min(Age_HC_Test_main),18), max(max(Age_HC_Test_main),100), 2000);
yline = coeff(1)*xline+coeff(2);
hold on
plot(xline,yline,'r-','DisplayName','HC' )
hold on


%% 2 MCI
% PCA Data reduction≈

[DataTrain_2, mapping] = pca(Train_Data , no_dims);
X2_MCI = Test_Data_MCI - repmat(mapping.mean, [size(Test_Data_MCI, 1) 1]);
Test_Data_MCI_t = X2_MCI * mapping.M;


MainData= [   DataTrain_2];
MainTest_MCI=[  Test_Data_MCI_t];
%
%Mdl_onTest_MCI = fitrsvm(MainData,Age_HC_Train_main,'Standardize',false,'KernelFunction','linear','OutlierFraction',0.0); % ,'KernelScale','auto'

PredictTest_MCI_Before= clf1.predict(MainTest_MCI);

%% Bias adjustment

PredictTest_MCI=[];

Offset=mean(q).*Test_Age_MCI+mean(qq);
for t=1:size(PredictTest_MCI_Before,1)
    PredictTest_MCI(t,1)=PredictTest_MCI_Before(t,1)-Offset(t,1);
end
%%


Mean_MCI_Final=mean(PredictTest_MCI-Test_Age_MCI)
MAE_MCI_Final=sum(abs(PredictTest_MCI-Test_Age_MCI))/numel(Test_Age_MCI);
RMSE_MCI_Final= (mean((PredictTest_MCI-Test_Age_MCI).^2))^0.5;
[R_MCI_Final, Pvalue2] = corr(PredictTest_MCI,Test_Age_MCI);
R2_MCI_Final=R_MCI_Final.*R_MCI_Final;
SEM2 = std(PredictTest_MCI-Test_Age_MCI)/sqrt(length(PredictTest_MCI-Test_Age_MCI));               % Standard Error
ts2 = tinv([0.025  0.975],length(PredictTest_MCI-Test_Age_MCI)-1);      % T-Score
CI2 = mean(PredictTest_MCI-Test_Age_MCI) + ts2*SEM2;
CI_test_MCI(1)=CI2(1);
CI_test_MCI(2)=CI2(2);

hold on
plot( Test_Age_MCI,PredictTest_MCI, 'bo' ,'DisplayName','MCI')


xlabel('Real age (years)')
ylabel('Estimated brain age (years)')
coeff = polyfit(Test_Age_MCI,PredictTest_MCI,1);
xline = linspace( min(min(Test_Age_MCI),18), max(max(Test_Age_MCI),100), 2000);
yline = coeff(1)*xline+coeff(2);
hold on
plot(xline,yline,'b-','DisplayName','MCI')
hold on




%% 3 AD
% PCA Data reduction≈
[DataTrain_2, mapping] = pca(Train_Data , no_dims);
X2_AD = Test_Data_AD - repmat(mapping.mean, [size(Test_Data_AD, 1) 1]);
Test_Data_AD_t = X2_AD * mapping.M;


MainData= [  DataTrain_2 ];
MainTest_AD=[  Test_Data_AD_t];
%
Mdl_onTest_AD = fitrsvm(MainData,Age_HC_Train_main,'Standardize',false,'KernelFunction','linear','OutlierFraction',0.0); % ,'KernelScale','auto'
%Mdl_onTest_HC = fitrlinear(MainData,Age_HC_Train_main,'Regularization','ridge'); % 'Regularization','ridge' or 'lasso';

PredictTest_AD_Before= clf1.predict(MainTest_AD);

%% Bias adjustment
PredictTest_AD=[];

Offset=mean(q).*Test_Age_AD+mean(qq);
for t=1:size(PredictTest_AD_Before,1)
    PredictTest_AD(t,1)=PredictTest_AD_Before(t,1)-Offset(t,1);
end
%%

Mean_AD_Final=mean(PredictTest_AD-Test_Age_AD)
MAE_AD_Final=sum(abs(PredictTest_AD-Test_Age_AD))/numel(Test_Age_AD);
RMSE_AD_Final= (mean((PredictTest_AD-Test_Age_AD).^2))^0.5;
[R_AD_Final, Pvalue2] = corr(PredictTest_AD,Test_Age_AD);
R2_AD_Final=R_AD_Final.*R_AD_Final;
SEM3 = std(PredictTest_AD -Test_Age_AD)/sqrt(length(PredictTest_AD -Test_Age_AD));               % Standard Error
ts3 = tinv([0.025  0.975],length(PredictTest_AD -Test_Age_AD)-1);      % T-Score
CI3 = mean(PredictTest_AD -Test_Age_AD) + ts3*SEM3;
CI_test_AD(1)=CI3(1);
CI_test_AD(2)=CI3(2);
hold on
plot( Test_Age_AD,PredictTest_AD, 'go' ,'DisplayName','AD')

xlabel('Real age (years)')
ylabel('Estimated brain age (years)')
coeff = polyfit(Test_Age_AD,PredictTest_AD,1);
xline = linspace( min(min(Test_Age_AD),18), max(max(Test_Age_AD),100), 2000);
yline = coeff(1)*xline+coeff(2);
hold on
plot(xline,yline,'g-','DisplayName','AD')
legend('Location','northwest','AutoUpdate','off');
qw=1:1:100;
qe=1:1:100;
plot(qw,qe,'--k')
fm = gcf;
exportgraphics(fm,'Linear_KRR.png','Resolution',300)
hold on

%% all results on test sets
Out_Features = [MAEtest RMSEtest MEANHCs R2_Train     MAE_HC_Final  RMSE_HC_Final  Mean_HC_Final R2_HC_Final MAE_MCI_Final  RMSE_MCI_Final   Mean_MCI_Final R2_MCI_Final  MAE_AD_Final RMSE_AD_Final  Mean_AD_Final R2_AD_Final];
Out_Train=[Age_HC_Train_main PredictTest (PredictTest-Age_HC_Train_main)];
Out_Test_HC=[Age_HC_Test_main PredictTest_HC (PredictTest_HC-Age_HC_Test_main)];
Out_Test_MCI=[Test_Age_MCI PredictTest_MCI (PredictTest_MCI-Test_Age_MCI)];
Out_Test_AD=[Test_Age_AD PredictTest_AD (PredictTest_AD-Test_Age_AD)];






Group = {'Training set : HC';'Test set : HC';'Test set : MCI';'Test set : AD'};
MAE = [MAEtest;MAE_HC_Final;MAE_MCI_Final;MAE_AD_Final];
RMSE = [RMSEtest;RMSE_HC_Final;RMSE_MCI_Final;RMSE_AD_Final];
R2 = [R2_Train;R2_HC_Final;R2_MCI_Final;R2_AD_Final];
CI=[CI_train_HC;CI_test_HC;CI_test_MCI;CI_test_AD];
Mean_Delta_Age = [MEANHCs;Mean_HC_Final;Mean_MCI_Final;Mean_AD_Final];
Results = table(Group,MAE,RMSE,R2,Mean_Delta_Age,CI)
[r,p]=corr( Age_HC_Test_main,PredictTest_HC-Age_HC_Test_main );
else
    disp("best_param file does not exist. Run Grid_Searcher.m first");
end