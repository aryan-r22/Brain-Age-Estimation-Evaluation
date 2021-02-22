     clc
     close all
     clear all
     format long
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
     
     [ n , m ] = size (Train_Data);
     
     K  = 10 ; % number of folds
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
     
     
     range = [2^(-8), 2^(-7), 2^(-6), 2^(-5), 2^(-4), 2^(-3), 2^(-2), 2^(-1), 1, 2, 4, 8, 16, 32, 64, 128, 256];
     
     %Range for all three parameters is the same
     
     count=1;
     
     
     for x12=range
         for y12=range
             for z12=range
                
               FunPara.p1=x12;
               FunPara.p2=x12;
               FunPara.p3=y12;
               FunPara.p4=y12;
               FunPara.p5=z12;
               FunPara.p6=z12;
               FunPara.kerfPara.type = 'lin';
               FunPara.kerfPara.pars = 3;%Not required for Linear
                 
                 
                 
                 
                
                     
      for  i =1:K                                 %for each fold  for i = 1 : K
         testIdx = (cvFolds == i);                % get indices of test instances
         trainIdx = ~testIdx;                     % get indices training instances
         %%  Age Section
         AgeTrain=Age_HC_Train_main(trainIdx,:);
         MainTestAge=Age_HC_Train_main(testIdx,:);
         %%  Voxel Section
         DataTrain_1=Train_Data(trainIdx,:);
         MainTestData_1=Train_Data(testIdx,:);
         %% PCA Data reductionÅ
         %no_dims=size(DataTrain_1,1)-1;
         [DataTrain, mapping] = pca(DataTrain_1 , no_dims);
         X2 = MainTestData_1 - repmat(mapping.mean, [size(MainTestData_1, 1) 1]);
         MainTestData = X2 * mapping.M;
            
         
         %% Regression Model
         
         %Mdl = fitrsvm(DataTrain,AgeTrain,'Standardize',false,'KernelFunction','linear','OutlierFraction',0.0); % ,'KernelScale','auto' . false
         %Mdl = fitrlinear(DataTrain,AgeTrain,'Regularization','ridge'); % 'Regularization','ridge' or 'lasso';
          d0.X = DataTrain;
                       d0.Y = AgeTrain;
                       XX = ETSVR(MainTestData,d0,FunPara);
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
     
     %     plot( Age_HC_Train_main,PredictTest, 'o' )
     %     xlabel('Real age (years)')
     %     ylabel('Estimated brain age (years)')
     %     coeff = polyfit(Age_HC_Train_main,PredictTest,1);
     %     xline = linspace( min(min(Age_HC_Train_main),18), max(max(Age_HC_Train_main),90), 2000);
     %     yline = coeff(1)*xline+coeff(2);
     %     hold on
     %     plot(xline,yline,'b-')
     %     hold on
     if(count==1)
         c1_best=x12;
         c3_best=y12;
         eps1_best=z12;
         minMAE=MAEtest;
         minRMSE=RMSEtest;
         minHCs=MEANHCs;
         minR2=R2_Train;
         count=count+1;
         continue;
     end
      if(MAEtest<minMAE)
          c1_best=x12;
          c3_best=y12;
          eps1_best=z12;
          minMAE=MAEtest;
          minRMSE=RMSEtest;
          minHCs=MEANHCs;
          minR2=R2_Train;
      end
      
          
             end
         end
     end
          
     save('best_params.mat','c1_best','c3_best','eps1_best'); 
          
    