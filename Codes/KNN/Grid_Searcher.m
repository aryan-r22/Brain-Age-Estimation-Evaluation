clc
close all
clear all
rng(1,'twister')


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
count=1;

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

range=1:1:10;
    
for k_val=range

    for  i =1:K                                 %for each fold  for i = 1 : K
        testIdx = (cvFolds == i);                % get indices of test instances
        trainIdx = ~testIdx;                     % get indices training instances
        %%  Age Section
        AgeTrain=Age_HC_Train_main(trainIdx,:);
        MainTestAge=Age_HC_Train_main(testIdx,:);
        %%  Voxel Section
        DataTrain_1=Train_Data(trainIdx,:);
        MainTestData_1=Train_Data(testIdx,:);
        %% PCA Data reduction�
        %no_dims=size(DataTrain_1,1)-1;
        [DataTrain, mapping] = pca(DataTrain_1 , no_dims);
        X2 = MainTestData_1 - repmat(mapping.mean, [size(MainTestData_1, 1) 1]);
        MainTestData = X2 * mapping.M;




        %% Regression Model
        metric = 'euclidean';
        weights = {'distance'}; %%Weighted mean
        mdl = kNNeighborsRegressor(k_val,metric,weights{1});
        mdl = mdl.fit(DataTrain,AgeTrain);
        XX = mdl.predict(MainTestData);
        
        PredictTest_Before(testIdx,1)=XX;



       
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
    
if(count==1)
    minMAE=MAEtest;
    best_k=k_val;
    count=count+1;
    continue;
end
if(MAEtest<minMAE)
    minMAE=MAEtest;
    best_k=k_val;
    
end
    
end
save("best_params.mat",'best_k')
 