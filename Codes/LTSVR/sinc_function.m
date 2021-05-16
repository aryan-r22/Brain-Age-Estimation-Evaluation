%sincnoise function
x1=-4.*pi+(8.*pi).*rand(200,1);
x1=sort(x1);
y=sin(x1)./x1;
y1=y+normrnd(0,0.2,200,1);
(x1,y1) %training sample

x2=-4.*pi+(8.*pi).*rand(500,1);
x2=sort(x2);
y2=sin(x2)./x2;
(x2,y2) %test sample

%sinc2 function
x1=-4.*pi+(8.*pi).*rand(500,1);
x1=sort(x1);
y=sin(x1)./x1;
y1=y+normrnd(0,0.2,500,1);
(x1,y1) %training sample

x2=-4.*pi+(8.*pi).*rand(1000,1);
x2=sort(x2);
y2=sin(x2)./x2;
(x2,y2) %test sample

%sinc5 function
x1=-4.*pi+(8.*pi).*rand(200,1);
x1=sort(x1);
y=sin(x1)./x1;
y1=y+x1;
(x1,y1) %training sample
x2=-4.*pi+(8.*pi).*rand(500,1);
x2=sort(x2);
y2=sin(x2)./x2;
(x2,y2) %test sample