function b = window(a, win_sz)
%   The one dimensional time series column vector is arranged as an
%   input-output matrix 'b' or [A y] matrix whose last column will be
%   the observed value for its corresponding input row vector.
%   Input is the one dimensional time series 'a' in a single column format.
%   Output is the augmented matrix [ A y ]where 
%   the number of input samples = m = ( length(a) - win_size + 1 ).
%   -----------------------------------------------------------------------

    b = [a(1:win_sz)'];
    m = length(a)-win_sz+1;
    for i = 2:m
        b = [b;a(i:i+win_sz-1)'];
    end