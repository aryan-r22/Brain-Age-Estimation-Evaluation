%%Sample2
%case1
x=(-10:20/199:10)'; %% for generating 200 samples uniformly for training
y=(4./(abs(x)+2))+cos(2.*x); %corresponding output
y1=y+normrnd(0,0.2,200,1);%Final output after adding the noises in the train output
(x,y1)%%train samples
xx=(-10:20/399:10)';%% for generating 400 samples uniformly for testing
y2=(4./(abs(xx)+2))+cos(2.*xx);%corresponding output
(xx,y2)%%test samples
%Case2
x=(-10:20/199:10)';%% for generating 200 samples uniformly for training
y=(4./(abs(x)+2))+cos(2.*x);%corresponding output
y1=y+normrnd(0,0.2,200,1);%Final output after adding the noises in the train output
(x,y1)%%train samples
xx=-10+20.*rand(400,1);%% for generating 400 samples randomly for testing
yy=(4./(abs(xx)+2))+cos(2.*xx);%corresponding output
(xx,yy)%%test samples
%Case 3
x1=-10+20.*rand(200,1);%% for generating 200 samples randomly for training
x1=sort(x1)
y11=(4./(abs(x)+2))+cos(2.*x);%corresponding output
y111=y11+normrnd(0,0.2,200,1);%Final output after adding the noises in the train output
(x1,y111)%%train samples
x2=-10+20.*rand(400,1);%% for generating 400 samples randomly for testing
x2=sort(x2);
y2=(4./(abs(x2)+2))+cos(2.*x2);%corresponding output
(x2,y2)%%test samples

%%Sample1
x1=(-15:30/199:15)';
y11=(4./(abs(x1)+2))+cos(2.*x1)+sin(3.*x1);
y111=y11+normrnd(0,0.2,200,1);
xx2=(-15:30/399:15)';
y22=(4./(abs(xx2)+2))+cos(2.*xx2)+sin(3.*xx2);
x1=(-15:30/199:15)';
y1=(4./(abs(x1)+2))+cos(2.*x1)+sin(3.*x1);
y11=y1+normrnd(0,0.2,200,1);
x2=-15+30.*rand(400,1);
y2=(4./(abs(x2)+2))+cos(2.*x2)+sin(3.*x2);


%%%%%%%%%%%Case 3(April06,2011)
x1=-15+30.*rand(200,1);%% for generating 200 samples randomly for training
x1=sort(x1);
y=(4./(abs(x1)+2))+cos(2.*x1)+sin(3.*x1);%corresponding output
y1=y-0.2+(0.4).*rand(200,1);%Final output after adding the noises in the train output
(x1,y1)%%training samples
x2=-15+30.*rand(500,1);%% for generating 500 samples randomly for testing
x2 = sort(x2);
y2=(4./(abs(x2)+2))+cos(2.*x2)+sin(3.*x2);%corresponding output
(x2,y2)%%test samples


%Using Gaussian Noise
x1=-10+20.*rand(200,1);%% for generating 200 samples randomly for training
x1=sort(x1);
y=(4./(abs(x1)+2))+cos(2.*x1)+sin(3.*x1);%corresponding output
y1=y+normrnd(0,0.2,200,1);%Final output after adding the noises in the train output
(x1,y1)%%training samples
x2=-10+20.*rand(1000,1);%% for generating 500 samples randomly for testing
x2 = sort(x2);
y2=(4./(abs(x2)+2))+cos(2.*x2)+sin(3.*x2);%corresponding output
(x2,y2)%%test samples

