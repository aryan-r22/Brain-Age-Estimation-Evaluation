
%For Function#1 
%%Part-1
x=(-15:30/299:15)';%% for generating 300 samples uniformly for training
y=((4./(abs(x)+2))+cos(2.*x)+sin(3.*x));%% corresponding output for training
y1=Yynormrnd(0,0.2,300,1);%%adding the noices randomly
% (x,y1) training
xx=(-15:30/599:15)';%% for generating 600 samples uniformly for training
yy=((4./(abs(xx)+2))+cos(2.*xx)+sin(3.*xx));%% randomly adding noices between interval(-15,15)
()




x=(-15:.1003:15)' %% for generating 300 samples uniformly for training
f1(x)=(4./(abs(x)+2)+cos(2.*x)+sin(3.*x)) %% corresponding output for training
% x=x+(-15+(15-(-15))*rand(300,1))%% randomly adding noices between interval(-15,15)
% (x,f1(x)) training
x=(-15+(15-(-15))*rand(600,1));%% for generating 600 samples randomly for testing
y=(4./(abs(x)+2)+cos(2.*x)+sin(3.*x));
y1=y+normrnd(0,0.2,600,1); %%adding the noices randomly
% plot(x,y,'b-',x,y1,'ro',x,y12,'g+'); %% if x is sorted
% 
% [x,I] = sort(x);
% y = y(I);
% y1 = y1(I);
% y12 = y12(I);
% plot(x,y,'b-',x,y1,'ro',x,y12,'g+'); %% if x is sorted


% (x,y1) testing

%For Function#2
x=(-10:.05003:10)' %% for generating 400 samples uniformly for training
f2(x)=((4./(abs(x)+2))+cos(2.*x)) %% corresponding output for training
% (x,f2(x)) training

xx=(-10:20/599:10);%% for generating 600 samples uniformly for testing
yy=((4./(abs(xx)+2))+cos(2.*xx));
y2=yy+normrnd(0,0.2,600,1);%% randomly adding noices between interval(-10,10)

% (xx,y2) testing
%plot(1:test_pt,test_data(:,no_col_pt),'r--',1:no_test,ytest0,'b.',1:test_pt,test,'g-')