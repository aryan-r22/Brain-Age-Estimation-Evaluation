clc
close all
clear all

rng(1,'twister'); %Seed


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




                             
    %%  Age Section
    AgeTrain=Age_HC_Train_main;
    MainTestAge=Age_HC_Train_main;
    %%  Voxel Section
    DataTrain_1=Train_Data;
    MainTestData_1=Train_Data;
    %% PCA Data reduction≈
    %no_dims=size(DataTrain_1,1)-1;
    [DataTrain, mapping] = pca(DataTrain_1 , no_dims);
    X2 = MainTestData_1 - repmat(mapping.mean, [size(MainTestData_1, 1) 1]);
    MainTestData = X2 * mapping.M;
       
    
    %% Regression Model
    
    %Mdl = fitrsvm(DataTrain,AgeTrain,'Standardize',false,'KernelFunction','linear','OutlierFraction',0.0); % ,'KernelScale','auto' . false
    %Mdl = fitrlinear(DataTrain,AgeTrain,'Regularization','ridge'); % 'Regularization','ridge' or 'lasso';
    Mdl=fitrtree(DataTrain,AgeTrain,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus','KFold',10));
    XX= predict(Mdl,MainTestData);
    PredictTest_Before=XX;
    
    
    


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
SEM_HC_Train = std(PredictTest -Age_HC_Train_main)/sqrt(length(PredictTest -Age_HC_Train_main));               % Standard Error
ts_HC_Train = tinv([0.025  0.975],length(PredictTest -Age_HC_Train_main)-1);      % T-Score
CI_HC_Train = mean(PredictTest -Age_HC_Train_main) + ts_HC_Train*SEM_HC_Train;
CI_min_HC_Train=CI_HC_Train(1);
CI_max_HC_Train=CI_HC_Train(2);

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
Mdl_onTest_HC=fitrtree(MainData,Age_HC_Train_main,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'))
PredictTest_HC_Before= predict(Mdl_onTest_HC,MainTest_HC);

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
SEM_HC_Test = std(PredictTest_HC-Age_HC_Test_main)/sqrt(length(PredictTest_HC-Age_HC_Test_main));               % Standard Error
ts_HC_Test = tinv([0.025  0.975],length(PredictTest_HC-Age_HC_Test_main)-1);      % T-Score
CI_HC_Test = mean(PredictTest_HC-Age_HC_Test_main) + ts_HC_Test*SEM_HC_Test;
CI_min_HC_Test=CI_HC_Test(1);
CI_max_HC_Test=CI_HC_Test(2);
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
Mdl_onTest_MCI=fitrtree(MainData,Age_HC_Train_main,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'));
PredictTest_MCI_Before= predict(Mdl_onTest_MCI,MainTest_MCI);

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
SEM_MCI_Test = std(PredictTest_MCI-Test_Age_MCI)/sqrt(length(PredictTest_MCI-Test_Age_MCI));               % Standard Error
ts_MCI_Test = tinv([0.025  0.975],length(PredictTest_MCI-Test_Age_MCI)-1);      % T-Score
CI_MCI_Test = mean(PredictTest_MCI-Test_Age_MCI) + ts_MCI_Test*SEM_MCI_Test;
CI_min_MCI_Test=CI_MCI_Test(1);
CI_max_MCI_Test=CI_MCI_Test(2);
hold on
plot( Test_Age_MCI,PredictTest_MCI, 'bo','DisplayName','MCI' )


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
%Mdl_onTest_AD = fitrsvm(MainData,Age_HC_Train_main,'Standardize',false,'KernelFunction','linear','OutlierFraction',0.0); % ,'KernelScale','auto'
%Mdl_onTest_HC = fitrlinear(MainData,Age_HC_Train_main,'Regularization','ridge'); % 'Regularization','ridge' or 'lasso';
Mdl_onTest_AD=fitrtree(MainData,Age_HC_Train_main,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'))
PredictTest_AD_Before= predict(Mdl_onTest_AD,MainTest_AD);

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
SEM_AD_Test = std(PredictTest_AD-Test_Age_AD)/sqrt(length(PredictTest_AD-Test_Age_AD));               % Standard Error
ts_AD_Test = tinv([0.025  0.975],length(PredictTest_AD-Test_Age_AD)-1);      % T-Score
CI_AD_Test = mean(PredictTest_AD-Test_Age_AD) + ts_AD_Test*SEM_AD_Test;
CI_min_AD_Test=CI_AD_Test(1);
CI_max_AD_Test=CI_AD_Test(2);
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
exportgraphics(fm,'Binary_Decision_Tree.png','Resolution',300)
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
Mean_Delta_Age = [MEANHCs;Mean_HC_Final;Mean_MCI_Final;Mean_AD_Final];
CI = [CI_HC_Train;CI_HC_Test;CI_MCI_Test;CI_AD_Test];
Results = table(Group,MAE,RMSE,R2,Mean_Delta_Age,CI)
[r,p]=corr( Age_HC_Test_main,PredictTest_HC-Age_HC_Test_main );