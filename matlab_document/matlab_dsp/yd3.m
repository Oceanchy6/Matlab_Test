echo on
clear;
K=10;%子信道数 10 
N=2*K;% 变换点数20
T=100;
a=rand(1,36);
a=sign(a-0.5);
b=reshape(a,9,4); %9行四列
% 基于 16QAM 的复数码元序列的生成
XXX=2*b(:,1)+b(:,2)+j*(2*b(:,3)+b(:,4)); 
XX=XXX';
X=[0 XX 0 conj(XX(9:-1:1))]; 
xt=zeros(1,101);
%生成抽样函数s(k)（式（13））
for t=0:100
for k=0:N-1
xt(1,t+1)=xt(1,t+1)+ X(k+1)*exp(1i*(2*pi/T)*(k)*(t))/sqrt(20);
echo off
end
end
echo on
xn=zeros(1,N);
%码元序列的 IDFT
for n=0:N-1
 for k=0:N-1
                  xn(n+1)=xn(n+1)+ X(k+1)*exp(1i*(2*pi/K)*n*k)/sqrt(20);
                 echo off
 end
end
echo on
pause %按任意键画出 x(t) plot([0:100],abs(xt))
% 计算 xn 和 x(t)抽样函数的差别
for n=0:N-1
d(n+1)=xt(T/N*n+1)-xn(1+n); echo off
end
echo on
e=norm(d); Y=zeros(1,10); for k=1:9
for n=0:N-1
Y(1,k+1)=Y(1,k+1)+ xn(n+1)*exp(-j*(2*pi/K)*n*k)/sqrt(20);
echo off
end
end
echo on
dd=Y(1:10)-X(1:10);
ee=norm(dd);