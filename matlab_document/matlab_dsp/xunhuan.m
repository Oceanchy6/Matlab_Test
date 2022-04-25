echo on
clear;
K=10;%子信道数 10 
N=2*K;% 变换点数20
T=100;
a=rand(1,36);
a=sign(a-0.5);       %生成码元
b=reshape(a,9,4);    % a的4个变成一行为一个码元
% 基于16QAM 的复数码元序列的生成
XXX=2*b(:,1)+b(:,2)+j*(2*b(:,3)+b(:,4));     %b矩阵每一行是四位，对应16QAM的一个复数
XX=XXX';
X=[0 XX 0 conj(XX(9:-1:1))];               %Bn'    
xt=zeros(1,101);

%生成抽样函数 （式（13））
for t=0:100
 for k=0:N-1 
    xt(1,t+1)=xt(1,t+1)+ X(k+1)*exp(j*(2*pi/T)*k*t)/sqrt(N); 
 echo off
 end
end
echo on     
xn=zeros(1,N);
%码元序列Bn'的 IDFT
for n=0:N-1
 for k=0:N-1
    xn(n+1)=xn(n+1)+ X(k+1)*exp(j*(2*pi/N)*n*k)/sqrt(N);
    xn_shift=[xn(N-3:N),xn];
    xn_shift(1:4)=[];
    xn=xn_shift;
   echo off
 end
end    
%这是x(t)抽样序列x(k)
echo on
pause %按任意键画出 x(t)
figure(1)
plot([0:100],abs(xt))
title('OFDM信号的恢复信号')
figure(2)
stem([0:N-1],abs(xn),'.')
title('OFDM信号的采样信号')
% 计算 xn 和 x(t)抽样函数的差别
for n=0:N-1
 d(n+1)=xt(T/N*n+1)-xn(1+n);
 echo off
end
echo on
e=norm(d)      %范数

%DFT
Y=zeros(1,10);
for k=1:9        %Y(1)=0不变
 for n=0:N-1
    Y(1,k+1)=Y(1,k+1)+ xn(n+1)*exp(-j*(2*pi/N)*n*k)/sqrt(N);
 echo off
 end
end

echo on
dd=Y(1:10)-X(1:10);
ee=norm(dd)