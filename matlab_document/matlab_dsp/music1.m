clear all;
N=128;
M=2;
f1=0.1;
f2=0.3;
n=0:N-1;

R=zeros(N,N);%自相关矩阵
xn=exp(-j*(2*pi*f1*n+pi/4))+exp(-j*(2*pi*f2*n+pi/3));%指数函数并非sin（x）正弦函数
snr=10;                 %snr为信噪比
yn=awgn(xn,snr);
Xk=xcorr(yn);%对yn求取自相关
%求自相关矩阵
for i=1:N
    for z=1:N
        if(i>=z) 
            R(i,z)=Xk(i-z+N);
        else
            R(i,z)=conj(Xk(z-i+N));
        end    
    end
end
[EV,D]=eig(R);%特征值分解 ，D为特征值矩阵对角线上的值即为特征值，matlab会自动按顺序排放
En=EV(:,1:N-2);  %噪声子空间
C=1001;%c为w的取值个数
w=linspace(0,1,C);%w为[0,1]取1001个值
P=zeros(1,C);
for i=1:C
    a=exp(-j*w(i)*2*pi*(0:N-1)');%a为N维列向量e（w）
    b=a';%对a进行转置
    P(i)=1/sum(  abs((b*En)).^2  );%构造类似功率谱的函数P（i）
end
plot(w,P);
xlabel('w/2/pi')%x轴
ylabel('归一化功率谱 (dB)')%y轴
title('music方法');