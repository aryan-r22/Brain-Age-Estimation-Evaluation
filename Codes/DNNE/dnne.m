function [dnneModel, TrainingAccuracy, TestingAccuracy, TrainingRMSE] = dnne(ensSize, baseSize, ...
    lambda, trainData, testData, method, randStream) 

% This is the main function to create a DNNE model from using a training
% data. It returns the training and testing accuracies as the RMSE for
% regresion problems and classification accuracy in classification
% problems. 
% [dnneModel, TrainingAccuracy, TestingAccuracy, TrainingRMSE] = dnne(ensSize, baseSize, ...
%     lambda, trainData) 
%     
% [dnneModel, TrainingAccuracy, TestingAccuracy, TrainingRMSE] = dnne(ensSize, baseSize, ...
%     lambda, trainData, testData) 
% 
% [dnneModel, TrainingAccuracy, TestingAccuracy, TrainingRMSE] = dnne(ensSize, baseSize, ...
%     lambda, trainData, testData, method, randStream) ALLOWS users to use
%     specific Random Stream to initiate the random numbers generator. This
%     allows users to have a control on the generated models. 
%    
%
% This software package has been developed by Monther Alhamdoosh (c) 2014
% based on this paper
% Monther Alhamdoosh, Dianhui Wang, Fast decorrelated neural network ensembles
% with random weights, Information Sciences, Volume 264, 20 April 2014, 
% Pages 104-117, ISSN 0020-0255, http://dx.doi.org/10.1016/j.ins.2013.12.016.
%
% For technical support and/or help, please contact m.hamdoosh@gmail.com
%
% This package has been downloaed from http://homepage.cs.latrobe.edu.au/dwang/

    onlyTraining = false;
    if (nargin == 4)
        onlyTraining = true;
    elseif (nargin == 5)
        method = 'reg';
    elseif (nargin == 7)            
        RandStream.setGlobalStream(randStream);
    end

    % Create DNNE Model 
    X = trainData(:, 2:end);
    T = trainData(:, 1);    
    if (strcmp(method, 'class'))
        TOrig = T;
        if min(TOrig) == 0
            TOrig = TOrig + 1;
        end        
        noClasses = max(TOrig);
        if (noClasses == 2)
            T = ones(size(TOrig,1), 1) * -1;
            T(TOrig == 1, 1) = 1;
        else
            T = ones(size(TOrig,1), noClasses) * -1;
            for i=1:noClasses
                T(TOrig == i, i) = 1;
            end
        end      
    end       
   
    dnneModel = newdnne(ensSize, baseSize, X, T, lambda);
    [dnneModel, TrainingRMSE] = traindnne(dnneModel, X, T);
    preds = simdnne(dnneModel, X, method);
    if (strcmp(method, 'reg'))
        TrainingAccuracy = TrainingRMSE;
    else        
        TrainingAccuracy = sum(TOrig == preds) / size(TOrig,1);
    end
    
    if (~onlyTraining)
        % Test the created DNNE Model on TestData
        X = testData(:, 2:end);
        T = testData(:, 1);    
        if (strcmp(method, 'class'))
             TOrig = T;
            if min(TOrig) == 0
                TOrig = TOrig + 1;
            end        
            noClasses = max(TOrig);
            if (noClasses == 2)
                T = ones(size(TOrig,1), 1) * -1;
                T(TOrig == 1, 1) = 1;
            else
                T = ones(size(TOrig,1), noClasses) * -1;
                for i=1:noClasses
                    T(TOrig == i, i) = 1;
                end
            end
        end    
        preds = simdnne(dnneModel, X, method);
        if (strcmp(method, 'reg'))
            if (dnneModel.noOutputs == 1)
                TestingAccuracy = sqrt(sum((T - preds).^2) / size(preds, 1));
            else
                TestingAccuracy = sqrt(sum(sum((T - preds).^2)) / (size(preds, 1) * dnneModel.noOutputs));
            end
        else            
            TestingAccuracy = sum(TOrig == preds) / size(TOrig,1);
        end    
    else
        TestingAccuracy = -1;
    end
    
end