
    file1 = fopen('resTLSVR_main.txt','w+');
    file2 = fopen('results_c1_c2_mu.txt','w+');
% cvs = [2^-10,2^-9,2^-8,2^-7];
%,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2.,4.,8.,16.,32.,64.];

  %% -------------------Code for Twin LSVR for regression-----------------------------
for load_file = 2:2
    switch load_file
        case 1
            file = 'auto';
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            
%             cvs1=10^-5;
%             cvs2=10^-5;
%             muvs= 2^-10; %optimum values and RMSE is 0.542567                     
        
        case 2
            file = 'bodyfat'; 
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=10^-1;
            cvs2=10^-1;
            muvs= 2^5;
            
         case 3
           file = 'machine'; 
%            cvs1=10^-5;
%            cvs2=10^-5;
%            muvs= 2^-6;
          
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];


         case 4
           file = 'servo'; 
           cvs1=10^-5;
           cvs2=10^-5;
           muvs= 2^-1; %optimum values and RMSE is 0.718656
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];

         case 5
            file = 'sinc';
            cvs1=10^-5;
            cvs2=10^-5;
            muvs= 2^-2;
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];

        case 6
            file = 'concreteCS'; 
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10],
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5]
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5]
%             cvs1=10^8;
%             cvs2=10^8;
%             muvs=2^-10;          
        
            
        case 7
            file = 'boston'; 
%             cvs1=10^5;
%             cvs2=10^5;
%             muvs= 2^-4;
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];

        case 8
            file = 'google'
            cvs1=[10^-5,10^-4,10^-1];
            cvs2=[10^-5,10^-4,10^-1];
            muvs= 2^4;
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];

        case 9
            file = 'ibm'
            cvs1=1;
            cvs2=1;
            muvs= 2^-10;
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];


         case 10
            file = 'kin900'
            cvs1=10^-1;
            cvs2=10^-1;
            muvs= 2^-10;
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];  

        case 11
            file = 'compuact900'
%              cvs1=10^-1;
%             cvs2=10^-1;
%             muvs= 2^-10;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
        case 12
            file = 'mg17'
%             cvs1=10^5;
%             cvs2=10^5;
%             muvs= 2^-5;
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10]; 

       case 13
            file = 'mg30'
            cvs1=10^5;
            cvs2=10^5;
            muvs= 2^-5;
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10]; 

      case 14
            file = 'redhat'
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
      case 15
            file = 'intel'
%             cvs1=10^3;
%             cvs2=10^3;
%             muvs= 2^4;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
      case 16
            file = 'SNP500'
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
      case 17
            file = 'NO2'
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
     case 18
            file = 'lorenz2'
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
     case 19
            file = 'wpbc'
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
    case 20
            file = 'lorenz4'
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
    case 21
            file = 'forestfires'
%             cvs1=10^5;
%             cvs2=10^5;
%             muvs= 2^-10;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
            
     case 22
            file = 'demo'
            cvs1=10^-5;
            cvs2=10^-5;
            muvs= 2^-10;
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];   
            
     case 23
            file = 'abalone'
%             cvs1=10^5;
%             cvs2=10^5;
%             muvs= 2^-10;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];   
            
      case 24
            file = 'ms_stock'
%             cvs1=10^5;
%             cvs2=10^5;
%             muvs= 2^-10;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5]
            
            
      case 25
            file = 'SantafeA'
%             cvs1=10^5;
%             cvs2=10^5;
%             muvs= 2^-10;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5]
            
      case 26
            file = 'sunspots94'
%             cvs1=10^5;
%             cvs2=10^5;
%             muvs= 2^-10;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5]
            
       case 27
            file = 'citigroup'
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];


      case 28
            file = 'sample_new1'           
            cvs1=10;
            cvs2=10;
            muvs= 2^-4;
%             muvs=[2^-14,2^-13,2^-12,2^-11,2^11,2^12,2^13,2^14];
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
            
      case 29
            file = 'sample2'           
            cvs1=10;
            cvs2=10;
            muvs= 2^-6;
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];

     case 30
            file = 'mexican3d_rand'
%             cvs1=10;
%             cvs2=10;
%             muvs= 2^-2;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];

     case 31
            file = 'friedman1'
%             cvs1=10;
%             cvs2=10;
%             muvs= 2^-2;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
                
      case 32
            file = 'multi'
            cvs1=10;
            cvs2=10;
            muvs= 2;
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
       case 33
            file = 'friedman2'
%             cvs1=10;
%             cvs2=10;
%             muvs= 2;
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
       case 34
            file = 'friedman3'
            cvs1=0.1;
            cvs2=0.1;
            muvs= 2;
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            
       case 35
            file = 'plane'
            cvs1=10;
            cvs2=10;
            muvs= 2^4;
%             muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
%             cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%             cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,
%             10^5];

       case 36
            file = 'new1'
            muvs=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
            cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            cvs2=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
            %new1_train.txt;  example no:36; RMSE =  33.8208, optimum_c1:10 optimum_c2:10 optimum_mu:0.125
     end
    
    trainfile= strcat('../dataset/',file,'_train.txt');
    testfile = strcat('../dataset/',file,'_test.txt');
    
    train_data = load(trainfile);
    [input,no_col]=size(train_data);
    test_data = load(testfile);
    [test_pt,no_col_pt] = size(test_data);
    A=[train_data; test_data];
    itmax=100; tol=0.00001; ep1=0.01; ep2=0.01; 
    
    
  %% Normalizing datasets  
%     X = normalize([train_data(:,1:no_col-1);test_data(:,1:no_col-1)]);
%     train_data(:,1:no_col-1) = X(1:size(train_data,1),:);
%     test_data(:,1:no_col-1) = X(size(train_data,1)+1:size(X,1),:);

    if (load_file== 2)  
        ndiv = 1000;
        sub = 30/ndiv;
        x = (-15:sub:15);
        
        f1x=(4./(abs(x)+2)+cos(2.*x)+sin(3.*x)) %% corresponding output for training
%         y = f1x + normrnd(0,0.2,ndiv+1,1)';
        y = f1x ;        
        train_data = [x' y'];
        
        [input,no_col]=size(train_data);
            
         ndiv = 1500;
         x=(-15+(15-(-15))*rand(ndiv+1,1));%% for generating 600 samples randomly for testing
        f1x=(4./(abs(x)+2)+cos(2.*x)+sin(3.*x)) %% corresponding output for training
%         y = f1x + normrnd(0,0.2,ndiv+1,1);
        y = f1x ; 
       test_data = [x y];
        [test_pt,no_col_pt] = size(test_data);
  
  
         train_data(:,1:no_col) = normalize(train_data(:,1:no_col));
         test_data(:,1:no_col) = normalize(test_data(:,1:no_col));
     end  
    
    
       
%% ----------------crossvalidation part-----------------     
%      no_part = 10.;
%     % initialize minimum error variable and corresponding c1 and c2
%     min_c1=1.;
%     min_c2=1.;    
%     min_RMSE=1000000000000000.; 
%     min_mu=1.;
%      for mui=1:length(muvs)
%         %for different values of mu
% %         mu=muvs(mui)
%         for c1i=1:length(cvs1)
%             mu=muvs(mui)
%             c1=cvs1(c1i)
%             c2=cvs1(c1i)
%                 %for different values of c1,c2
%    
%   %% training statement
%             block_size=input/no_part;
%             part=0;
%             avgRMSE=0;
%             t_1=0;
%             t_2=ceil(part*block_size);
%             while ((part+1)* block_size)<=input
%                 t_1= t_2;
%                 t_2=ceil((part+1)*block_size);
%                 Data =[train_data(1:t_1,:); train_data(t_2+1:input,:)];
%                 Data_test= train_data(t_1+1: t_2,:);
%                 [u1,u2]=lsvm(Data,ep1,ep2,c1,c2,mu,itmax,tol);
%                   
%                 [RMSE]=test_train_regression (Data,Data_test,ep1,ep2,mu,u1,u2);%call for training and testing
%                 fprintf(file2, 'example file %s; RMSE= %8.6g, part num= %8.6g, c1= %8.6g,c2= %8.6g, mu= %8.6g\n', file,RMSE,part,c1,c2,mu);
%                 avgRMSE = avgRMSE + RMSE;
%                 part=part+1;
%             end
%    %% testing statement
%             %for particular c1,c2 and for particular file
%              fprintf(file2, 'example no: %s\t avgRMSE: %g\t c1=%g\t c2=%g\t mu=%g\n',testfile, avgRMSE,c1,c2,mu);
%              if avgRMSE < min_RMSE
%                  min_c1=c1;
%                  min_c2=c2;
%                  min_RMSE=avgRMSE;
%                  min_mu=mu;
%              end
%                
%         end %for c1 values
%     end %for mu values
    
   %% final training
    t=cputime;  
                min_mu = muvs;
                min_c1 = cvs1;
                min_c2 = cvs2;
                 
%   Replace comments by uncomments and vice-versa before this.

 [u1,u2]=lsvm(train_data,ep1,ep2,min_c1,min_c2,min_mu,itmax,tol);
%  [RMSE_train,train_test]=test_train_classifier (train_data,train_data,min_ep1,min_ep2,min_mu,u1,u2);      
 [RMSE,test]=test_train_regression (train_data,test_data,ep1,ep2,min_mu,u1,u2);              
 fprintf(file1,'File Name:%s;  example no:%d; RMSE = %8.6g, optimum_c1:%g\toptimum_c2:%g optimum_mu:%g\n', trainfile,load_file,RMSE,min_c1, min_c2,min_mu);
 fclose(file1);
 file1 = fopen('resTLSVR_main.txt','a+');
 plot((1:1:test_pt)',test_data(:,no_col_pt),'r',(1:1:test_pt)',test,'b')
 plot(test_data(:,1), f1x,'r.',test_data(:,1),test,'b.');
 %  pause
%   plot((1:1:input)',train_data(:,no_col_pt),'b',(1:1:input)',train_test,'r')
end  
fclose(file1);
fclose(file2);
%% ------------------completed---------------------------------------