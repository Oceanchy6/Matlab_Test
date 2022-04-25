x=[1 2 3 4 5];  %生成 x(n)
h=[1 2 1 2];  %生成 h(n)

N0=5;   %卷积点数
N1=6;
N2=8;
N3=10;

y1=conv(x,h);
y2=circonv(x,h,N0);
y3=circonv(x,h,N1);  
y4=circonv(x,h,N2);
y5=circonv(x,h,N3);



%conv线性卷积
n=0:length(y1)-1;
subplot(5,1,1);
stem(n,y1,'.');
title('conv线性卷积');
xlabel('n');
ylabel('y1(n)');
grid on;


%5点圆卷积
n=0:length(y2)-1;
subplot(5,1,2);
stem(n,y2,'.');
title('5点圆卷积');
xlabel('n');
ylabel('y2(n)');
grid on;


%6点圆卷积
n=0:length(y3)-1;
subplot(5,1,3);
stem(n,y3,'.');
title('6点圆卷积');
xlabel('n');
ylabel('y3(n)');
grid on;

%8点圆卷积
n=0:length(y4)-1;
subplot(5,1,4);
stem(n,y4,'.');
title('8点圆卷积');
xlabel('n');
ylabel('y4(n)');
grid on;

%10点圆卷积
n=0:length(y4)-1;
subplot(5,1,5);
stem(n,y4,'.');
title('10点圆卷积');
xlabel('n');
ylabel('y4(n)');
grid on;