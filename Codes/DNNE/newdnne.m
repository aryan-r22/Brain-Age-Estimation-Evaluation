function dnne = newdnne(ensSize, baseSize, X, T, lambda)
    % This is the main function and it is used to create a DNNE model.
%    dnne = newdnne(ensSize, baseSize, X, T, lambda) RETURNS an empty DNNE model.
%    It creates a RVFL neural network ensemble of size ensSize and all its parameters are set to zero. 
%    The number of hidden neurons in each base RFVL network is baseSize. 
%    X and T are the input and targets training vectors, respectively. 
%    Each row in these two matrices represent on input-target instance. 
%    lambda is a regularization factor that is used in the DNNE learning algorithm.     
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

    dnne.baseModels = {};
    dnne.ensSize = ensSize;
    dnne.baseSize = baseSize;
    dnne.noInputs = size(X, 2);
    dnne.noOutputs = size(T,2);
    dnne.train.lambda = lambda;
    dnne.train.trained = false;    
    for i=1:ensSize
        dnne.baseModels(i).inputWeights = zeros(baseSize, size(X, 2)); % L x n
        dnne.baseModels(i).hiddenBiases = zeros(baseSize, 1);
        dnne.baseModels(i).outputWeights = zeros(baseSize, size(T,2)); % L x t
        dnne.baseModels(i).actFunc = 'sig';
    end
    disp('New DNNE model has been created.')
end