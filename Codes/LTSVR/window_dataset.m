     %% for time series dataset
     file='sunspots94'
    A=load(strcat('../dataset/',file,'.txt'));
    win_size = 5+1;
    [input,no_col] = size(A);
    if no_col == 1
        A = window(A,win_size)
        input = input - win_size + 1;
    end