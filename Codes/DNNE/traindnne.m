function [dnne, rmse] = traindnne(dnneInit, X, T)
%     This function runs the DNNE learning algorithm to optimize the ensemble model parameters
%     [dnne, rmse] = traindnne(dnneInitial, X, T) RETURNS a trained DNNE model and 
%     the root mean square error as an estimate to the learning error. It takes an empty DNNE model dnneInit,
%     input feature vectors X that is N x n matrix and target vectors T that is N x t matrix
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

    disp('Training DNNE model has just commenced.');
    dnne = dnneInit;
    M = dnne.ensSize;
    L = dnne.baseSize;
    N = size(X, 1);
    if (dnne.noInputs ~= size(X, 2) || dnne.noOutputs ~= size(T, 2))
        err = MException('DNNE:DimensionsMismatch', 'Number of input/output variables should match number of ensemble inputs/outputs');
        throw(err);
    end
    ML = M * L;
    % Initialize network weights 
    for i=1:M        
        net = dnne.baseModels(i);
        dnne.baseModels(i).inputWeights = 2 * rand(size(net.inputWeights)) - 1;
        dnne.baseModels(i).hiddenBiases = rand(size(net.hiddenBiases));
    end    
    % Compute hidden output matrices
    baseHs = {}; % N x L
    for i=1:M
        net = dnne.baseModels(i);
        wx = net.inputWeights * X'; % L x N 
        H = wx + net.hiddenBiases * ones(1, size(wx, 2));
        baseHs{i} = logsig(H');% N x L
    end    
    clear net wx H;
    % Compute the global hidden matrix
    C1 = 1 - 2 * dnne.train.lambda * ((M -1) / M)^2;    
    C2 = 2 * dnne.train.lambda * (M-1) / M^2;
    Hcorr = zeros(ML, ML);
    for p=1:ML
        m = ceil(p / L);    
        n = mod(p-1, L) + 1;
        for q=1:ML
            k = ceil(q / L);
            l = mod(q-1, L) + 1;
            alpha = dot(baseHs{m}(1:N, n), baseHs{k}(1:N, l));
            if (m == k)
                Hcorr(p, q) = C1 * alpha;
            else
                Hcorr(p, q) = C2 * alpha;
            end
        end        
    end
    clear m n k l p q;
    % Compute the global target matrix
    Th = zeros(ML, dnne.noOutputs); % ML x t
    k=1;
    for i=1:M
        for j=1:L
            Th(k, 1:dnne.noOutputs) = baseHs{i}(1:N, j)' * T;
            k = k + 1;
        end
    end
    % Compute the global output weights matrix
    HcorrInv = pinv(Hcorr); % ML x ML
    Bens = HcorrInv * Th; % ML x t
    % Assign output eights to each individual RVFL network
    for i=1:M        
        dnne.baseModels(i).outputWeights = Bens((i-1) * L + 1:i * L, :);
    end
    dnne.train.trained = true;
    
    % Compute the RMSE on the training data
    netOut = simdnne(dnne, X, 'reg');
    if (dnne.noOutputs == 1)
        rmse = sqrt(sum((T - netOut).^2) / N);
    else
        rmse = sqrt(sum(sum((T - netOut).^2)) / (N * dnne.noOutputs));
    end
    disp('Training DNNE model has just completed.');
end


