
    file1 = fopen('KNNWTSVR_sor.txt','w+');
    file2 = fopen('results_c1_c2_mu.txt','w+');
 itmax=100; precision = 10^(-5); epsilon=0.01; 
    win_sz = 5+1;

  %% -------------------Code for Robust LTSVR for regression-----------------------------
for load_file = 5:5
    switch load_file
         
   
            
		
			 
		 case 1
            file = 'sunspots94';
             test_start=101;
			 
		case 2
            file = 'citigroup';
             test_start=201;
			 
		
			
		       case 3
            file = 'ibm';
            test_start=201;
			
		
     
		
	  case 4
            file = 'redhat';
              test_start=201;

					  
      case 5
            file = 'intel';
             test_start=201;
			 
		
      case 6
            file = 'SNP500';
            test_start=201;
           
		
      case 7
            file = 'lorenz2';
             test_start=501;

		
     case 8
            file = 'lorenz4';
	 test_start=501; 

		 
     case 9
            file = 'NO2';  
              test_start = 101;                
         
		
    
       case 10
            file = 'servo';
           test_start=101;
           
		
       

      case 11
            file = 'gasfurnace'; 
		 test_start=101;
            
		
    
            
        
		                 
 case 27
            file = 'Function1'
            test_start=101;
            
        case 28
            file = 'Function2'
            test_start=101;
            
		cvs1=10^3;
		cvs2=10^-3;
		muvs=2^-5;
        case 29
            file = 'Function3'
            test_start=101;
			
		cvs1=10^2;
		cvs2=10^-5;
		muvs=2^-2;
            
        case 30
            file = 'Function4'
            test_start=101;
			
		cvs1=10^5;
		cvs2=10^-3;
		muvs=2^-4;
            
        case 31
            file = 'Function5'
            test_start=101;
            
		cvs1=10^2;
		cvs2=10^-2;
		muvs=2^-1;
        case 32
            file = 'Function6'
            test_start=101;
            
		cvs1=10^1;
		cvs2=10^-1;
		muvs=2^4;
        case 33
            file = 'Function7'
            test_start=101;
            
		cvs1=10^2;
		cvs2=10^-2;
		muvs=2^3;
        case 34
            file = 'Function8'
            test_start=101;
           
		cvs1=10^2;
		cvs2=10^0;
		muvs=2^-4; 
        case 35
            file = 'Function9'
            test_start=101;
            
		cvs1=10^3;
		cvs2=10^-3;
		muvs=2^1;
        case 36
            file = 'Function10'
            test_start=101;
            
		cvs1=10^3;
		cvs2=10^0;
		muvs=2^-10;
        case 37
            file = 'Function11'
            test_start=101;
            
		cvs1=10^2;
		cvs2=10^-1;
		muvs=2^1;
        case 38
            file = 'Function12'
            test_start=101;
            
		cvs1=10^3;
		cvs2=10^-3;
		muvs=2^4;
        case 39
            file = 'Function13'
            test_start=101;
            
		cvs1=10^1;
		cvs2=10^-4;
		muvs=2^3;
        case 40
            file = 'Function14'
            test_start=101
			
		cvs1=10^2;
		cvs2=10^-5;
		muvs=2^-5;
            
        case 41
            file = 'Function15'
            test_start=101;
            
		cvs1=10^3;
		cvs2=10^-5;
		muvs=2^1;
        case 42
            file = 'Function16'
            test_start=101;
			
		cvs1=10^1;
		cvs2=10^3;
		muvs=2^-9;
        case 43
            file = 'Function17'
            test_start=101;
            
		cvs1=10^0;
		cvs2=10^-1;
		muvs=2^4;
        case 44
            file = 'Function18'
            test_start=101;
            
		cvs1=10^2;
		cvs2=10^-5;
		muvs=2^4;
        case 45
            file = 'Function22a'
            test_start=101;
			
		cvs1=10^2;
		cvs2=10^-5;
		muvs=2^1;
            
        case 46
            file = 'Function22b'
            test_start=101;
            
		cvs1=10^3;
		cvs2=10^-5;
		muvs=2^1;
        case 47
            file = 'Function22c'
            test_start=101;
       
		cvs1=10^1;
		cvs2=10^-5;
		muvs=2^2;


      
            otherwise
            continue; 
    end
     muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[0.25 ,0.50,0.75,1,1.25,1.50,1.75]; 
            
%             cvs1=10^1;
% 		    cvs2=10^-5;
% 		    muvs=2^2;

   filename = strcat('../dataset/',file,'.txt');
        A = load(filename);
     %% windowing, for time series only
    win_sz = 5+1;
    [m,n] = size(A);
    if n == 1
        A = window(A,win_sz);
        m = m - win_sz + 1;
    end
   
    [m,n] = size(A);
    test_data = A(test_start:m,:);
    if test_start > 1
        train_data = A(1:test_start-1,:);
    end    
   [input,no_col]=size(train_data);
    [test_pt,no_col_pt] = size(test_data);
    %A=[train_data; test_data];
    
    %% Normalize datasets    
    train_data(:,1:no_col) = scale(train_data(:,1:no_col));
    test_data(:,1:no_col)  = scale(test_data(:,1:no_col));
    
    itmax=100; tol=0.00001;   ep1=0.01;ep2=0.01; 
    
  %% Normalizing datasets  
%     X = normalize([train_data(:,1:no_col-1);test_data(:,1:no_col-1)]);
%     train_data(:,1:no_col-1) = X(1:size(train_data,1),:);
%     test_data(:,1:no_col-1) = X(size(train_data,1)+1:size(X,1),:);

% %     if (load_file==36)  
%          train_data(:,1:no_col) = normalize(train_data(:,1:no_col));
%          test_data(:,1:no_col) = normalize(test_data(:,1:no_col));
%     end  
    
    
       
%% ----------------crossvalidation part-----------------     
     no_part = 10.;
    % initialize minimum error variable and corresponding c1 and c2
   min_c1=111111111111.;
    min_c2=111111111111.;    
    min_RMSE=10^100.; 
    min_mu=2^-12.;
      for mui=1:length(muvs)
	  mu=muvs(mui)
        %for different values of mu
%         mu=muvs(mui)
        for c1i=1:length(cvs1)
		c1=cvs1(c1i)
            for c2i=1:length(cvs2)
            
            
            c2=cvs2(c2i)                      
                %for different values of c1 and c2
   
  %% training statement
            block_size=input/no_part;
            part=0;
            avgRMSE=0;
            t_1=0;
            t_2=ceil(part*block_size);
            while ((part+1)* block_size)<=input
                t_1= t_2;
                t_2=ceil((part+1)*block_size);
                Data =[train_data(1:t_1,:); train_data(t_2+1:input,:)];
                Data_test= train_data(t_1+1: t_2,:);
                [u1,u2,D]=lsvm(Data,ep1,ep2,c1,c2,mu,itmax,tol);
                %[u1,u2]=lsvm(Data,ep1,ep2,c1,c2,mu,itmax,tol);
                [RMSE]=test_train_regression (Data,Data_test,c2,mu,u1,u2,D);%call for training and testing
                fprintf(file2, 'example file %s; RMSE= %8.6g, part num= %8.6g, c1= %8.6g,c2= %8.6g, mu= %8.6g\n', file,RMSE,part,c1,c2,mu);
                avgRMSE = avgRMSE + RMSE;
                part=part+1;
            end
   %% testing statement
            %for particular c1,c2 and for particular file
             fprintf(file2, 'example no: %s\t avgRMSE: %g\t c1=%g\t c2=%g\t, mu=%g\n',filename, avgRMSE,c1,c2,mu);
             if avgRMSE < min_RMSE
                 min_c1=c1;
                 min_c2=c2;
                 min_RMSE=avgRMSE;
                 min_mu=mu;
             end
               
            end %for c2 values
        end %for c1 values
    end %for mu values
% %  
   % final training
      
%                 min_mu = muvs;
%                 min_c1 = cvs1;
%                 min_c2 = cvs2;
%                  
%   Replace comments by uncomments and vice-versa before this.

 [u1,u2,D,time]=lsvm(train_data,ep1,ep2,min_c1,min_c2,min_mu,itmax,tol);   
  [RMSE,MAE,NMSE,R2,test]=test_train_regression (train_data,test_data,min_c2,min_mu,u1,u2,D);
%  RMSE
 % [u1,u2]=lsvm2(train_data,ep1,ep2,min_c1,min_c2,min_mu,itmax,tol);
%   [RMSE,train]=test_train_regression(train_data,train_data,ep1,ep2,min_mu,u1,u2); %for calculating train error
 plotfile=strcat(file,'.mat');
 save(plotfile,'test_data','train_data','test', 'RMSE', 'min_c1', 'min_c2','min_mu','time');
 fprintf(file1,'File Name:%s;  example no:%d; RMSE = %8.6g,MAE = %8.6g,NMSE = %8.6g,R2 = %8.6g, optimum_c1:%g\toptimum_c2:%g optimum_mu:%g, time %8.6g\n', filename,load_file,RMSE,MAE,NMSE,R2,min_c1, min_c2,min_mu,time);
fclose(file1);
 file1 = fopen('KNNWTSVR_sor.txt','a+');
%  plot((1:1:test_pt)',test_data(:,no_col_pt),'r-',(1:1:test_pt)',test,'b-')
plot(test_data(:,1),test_data(:,no_col_pt),'r.',test_data(:,1),test,'b.')
 %  pause
%   plot((1:1:input)',train_data(:,no_col_pt),'b',(1:1:input)',train_test,'r')
ya=test_data(:,end);
x0 = 1:1:length(test_data);
plot(x0,ya,'r-',x0,test,'b-')
 xlabel('Index of Data Samples');
    ylabel('Predicted/Observed value');
    title(' Predicted and Observed values for the Testing Samples');
    h = legend('Observed','Predicted',2);
    set(h,'Interpreter','none')

end  
fclose(file1);
fclose(file2);
%% ------------------completed---------------------------------------