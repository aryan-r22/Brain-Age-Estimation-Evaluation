function T = simdnne(dnne, X, method)
    % This function simulates the DNNE model on a given input data
%     T = simdnne(dnne, X, method) RETURNS the prediction values in case of regression problems 
%     or class labels in case of classification. It takes a trained DNNE model as an argument along 
%     with input feature vectors X. Each row in X represents one input
%     instance. 
%     method determines whether a regressor or classifier predictions are computed. It takes one of these
%     two values 'reg' or 'class'.    
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

    if (dnne.noInputs ~= size(X, 2))
        err = MException('DNNE:DimensionsMismatch', 'Number of input variables should match number of ensemble inputs');
        throw(err);
    end
    
    if (~dnne.train.trained)
        err = MException('DNNE:Training', 'The DNNE model has not been trained yet.');
        throw(err);
    end
    
    if (nargin == 2)
        method = 'reg';
    end
    
    % Compute individual base model predictions
    M = dnne.ensSize;
    N = size(X, 1);
    indPredsRaw = cell(M); % M
    for i=1:M 
        net = dnne.baseModels(i);
        wx = net.inputWeights * X'; % L x N 
        H = wx + net.hiddenBiases * ones(1, size(wx, 2));
        netOut = logsig(H') * net.outputWeights; % N x t
        indPredsRaw{i} = netOut;
    end
    % Combine base model predictions
    t = size(indPredsRaw{1}, 2);
    if (strcmp(method, 'reg'))
        % Simple average is used to compute ensemble predictions
        T = zeros(N, t);
        for i=1:M
            T = T + indPredsRaw{i};
        end
        T = T / M;    
    elseif (strcmp(method, 'class'))
        % Majority voting procedure is used to assign class labels
        indPredsClass = zeros(N, M);
        if (dnne.noOutputs > 1)
            for i=1:M
                [m indPredsClass(:, i)] = max(indPredsRaw{i}, [], 2);
            end
        else
            for i=1:M
                indPredsClass(:, i) = ones(N, 1);
                indPredsClass(indPredsRaw{i} < 0, i) = 2;
            end
        end
        T =  mode(indPredsClass,2);
    end
end